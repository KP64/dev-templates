{
  settings.global.excludes = [
    "UNLICENSE"
    "*.gitignore"
  ];

  programs = {
    # nix
    deadnix.enable = true;
    statix.enable = true;
    nixfmt = {
      enable = true;
      strict = true;
    };

    # just
    just.enable = true;

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
