{
  programs = {
    # nix
    deadnix.enable = true;
    statix.enable = true;
    nixfmt.enable = true;

    # just
    just.enable = true;

    # markdown
    mdformat.enable = true;

    # shell
    shfmt.enable = true;

    # rust
    rustfmt.enable = true;
    leptosfmt.enable = true;

    # toml
    taplo.enable = true;

    # multiple
    prettier.enable = true;
  };
}
