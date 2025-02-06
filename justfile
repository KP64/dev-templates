# Run all Checks
all:
    just flake
    just links
    just actions

# Check the flake
flake:
    @nix flake check

# Check links with lychee
links:
    @nix shell nixpkgs#lychee --command lychee ./*.md ./*.nix ./hosts/**/*.nix

# Check Github Actions
actions:
    @nix shell nixpkgs#zizmor --command zizmor -p .github/workflows/

