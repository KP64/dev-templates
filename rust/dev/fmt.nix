{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt.programs = {
    deadnix.enable = true;
    statix.enable = true;
    nixf-diagnose.enable = true;
    nixfmt = {
      enable = true;
      strict = true;
    };

    prettier.enable = true;

    shellcheck.enable = true;
    shfmt.enable = true;

    rustfmt.enable = true;
    taplo.enable = true;
  };
}
