{
  perSystem =
    { self', pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        name = "template"; # TODO: Change name

        inputsFrom = builtins.attrValues self'.packages;

        packages = with pkgs; [
          # Nix lsp ❄️
          nil

          # Debugging 🦀
          lldb

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
          cargo-sort
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
