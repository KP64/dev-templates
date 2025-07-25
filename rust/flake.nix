{
  description = "Fully featured flake ❄️ for rusty 🦀 development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      imports = [ inputs.treefmt-nix.flakeModule ];

      perSystem =
        {
          self',
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ (import inputs.rust-overlay) ];
          };

          treefmt.programs = {
            deadnix.enable = true;
            statix.enable = true;
            nixfmt = {
              enable = true;
              strict = true;
            };

            prettier.enable = true;

            shfmt.enable = true;

            rustfmt.enable = true;
            leptosfmt.enable = true;

            taplo.enable = true;
          };

          packages.default = pkgs.callPackage ./package.nix { inherit (inputs) self; };

          devShells.default = pkgs.mkShell {
            inputsFrom = [ self'.packages.default ];

            packages = with pkgs; [
              # Nix lsp ❄️
              nil

              # Dependencies 📦
              cargo-edit
              cargo-udeps
              cargo-machete

              # Extra reinforcement 😂
              cargo-mommy

              # File watcher 👀
              bacon

              # Inner workings ⚙️
              cargo-show-asm
              cargo-expand

              # Release 🎉
              cargo-release
              cargo-semver-checks

              # License 📜
              cargo-license
              cargo-deny

              # Misc ❔
              cargo-msrv
              typos

              # Next gen testing 🧪
              cargo-nextest
              cargo-flamegraph
              cargo-mutants
              cargo-tarpaulin

              # Supply chain ⛓️
              cargo-vet
              cargo-audit
              cargo-auditable
              cargo-crev

              # Tasks 🛠️
              cargo-make
              cargo-chef
              cargo-cross

              # Unsafe ☢️
              cargo-geiger
            ];
          };
        };
    };
}
