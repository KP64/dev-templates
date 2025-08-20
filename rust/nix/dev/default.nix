{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { self', pkgs, ... }:
    {
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
}
