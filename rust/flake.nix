{
  description = "Fully featured flake ❄️ for rusty 🦀 development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    crane.url = "github:ipetkov/crane";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;

      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      imports = [ flake-parts.flakeModules.partitions ];

      partitionedAttrs = {
        checks = "dev";
        devShells = "dev";
        formatter = "dev";
      };

      partitions.dev = {
        extraInputsFlake = ./nix/dev;
        module.imports = [ ./nix/dev ];
      };
      perSystem =
        {
          self',
          inputs',
          lib,
          pkgs,
          ...
        }:
        let
          toolchain = inputs'.fenix.packages.fromToolchainFile {
            file = ./rust-toolchain.toml;
            sha256 = lib.fakeSha256; # TODO: Add Sha
          };

          craneLib = (inputs.crane.mkLib pkgs).overrideToolchain (_: toolchain);

          commonArgs = {
            src = craneLib.cleanCargoSource ./.;
            strictDeps = true;
            nativeBuildInputs = lib.optional pkgs.stdenv.isLinux pkgs.mold;
          };

          cargoArtifacts = craneLib.buildDepsOnly commonArgs;
          # TODO: Change Placeholders to actual names.
          Placeholder = craneLib.buildPackage (commonArgs // { inherit cargoArtifacts; });
        in
        {
          packages.default = Placeholder;

          checks = self'.packages // {
            PlaceholderClippy = craneLib.cargoClippy (
              commonArgs
              // {
                inherit cargoArtifacts;
                cargoClippyExtraArgs = "--all-targets";
              }
            );
            PlaceholderDoc = craneLib.cargoDoc (commonArgs // { inherit cargoArtifacts; });
            PlaceholderDeny = craneLib.cargoDeny { inherit (commonArgs) src; };
            PlaceholderNextest = craneLib.cargoNextest (commonArgs // { inherit cargoArtifacts; });
          };
        };
    };
}
