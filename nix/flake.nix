{
  description = "Fully featured flake ❄️ for flaky ❄️ development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      imports = [ inputs.treefmt-nix.flakeModule ];

      perSystem = { pkgs, ... }: {
        treefmt.programs = {
          deadnix.enable = true;
          statix.enable = true;
          nixfmt = {
            enable = true;
            strict = true;
          };

          shfmt.enable = true;
        };

        devShells.default = pkgs.mkShell {
          name = "template"; # TODO: Change name

          packages = with pkgs; [
            # Nix lsp ❄️
            nil

            # Check inputs & vulnerabilities
            nix-melt
            vulnix

            # Nixpkgs devtools
            nix-init
            nixpkgs-lint-community
            nixpkgs-review
          ];
        };
      };
    };
}
