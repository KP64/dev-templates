{
  nix = {
    path = ./nix;
    description = "Fully featured nix development flake";
  };

  rust = {
    path = ./rust;
    description = "Fully featured rust development flake";
    welcomeText = ''
      # Getting started 🦀
      1. `cd` into the project
      2. `nix run nixpkgs#cargo init .`
      3. `nix run nixpkgs#cargo generate-lockfile`
      4. `git add -A`
      5. `nix develop`
      6. Insert correct hash into `packages.nix`
      7. Add metadata in `packages.nix`

      # Nix an existing project ❄️
      1. `cargo generate-lockfile` (to generate Cargo.lock if not present)
      2. `git add -A`
      3. Add metadata in `packages.nix`
      4. `nix build` or `nix run` to build or run respectively
    '';
  };
}
