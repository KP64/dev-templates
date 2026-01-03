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
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      imports = [ flake-parts.flakeModules.partitions ];

      partitionedAttrs = {
        checks = "dev";
        devShells = "dev";
        formatter = "dev";
      };

      partitions.dev = {
        extraInputsFlake = ./dev;
        module.imports = [ ./dev ];
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
          craneLib = (inputs.crane.mkLib pkgs).overrideToolchain inputs'.fenix.packages.stable.toolchain;

          commonArgs = {
            src = craneLib.cleanCargoSource ./.;
            strictDeps = true;
            nativeBuildInputs = lib.optional pkgs.stdenv.isLinux pkgs.mold;
          };

          cargoArtifacts = craneLib.buildDepsOnly commonArgs;
          # TODO: Change Placeholders to actual names.
          placeholder = craneLib.buildPackage (commonArgs // { inherit cargoArtifacts; });
        in
        {
          packages.default = placeholder;

          checks = self'.packages // {
            placeholderClippy = craneLib.cargoClippy (
              commonArgs
              // {
                inherit cargoArtifacts;
                cargoClippyExtraArgs = "--all-targets";
              }
            );
            placeholderDoc = craneLib.cargoDoc (commonArgs // { inherit cargoArtifacts; });
            placeholderDeny = craneLib.cargoDeny { inherit (commonArgs) src; };
            placeholderNextest = craneLib.cargoNextest (
              commonArgs
              // {
                inherit cargoArtifacts;
                cargoExtraArgs = "--no-tests warn"; # TODO: remove when tests are implemented
              }
            );
          };
        };
    };
}
