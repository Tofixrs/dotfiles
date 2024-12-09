{
  inputs,
  inputs',
  pkgs,
  ...
}: let
  pkg = inputs'.ags.packages.default.override {
    extraPackages = inputs.ags-config.lib.modules {inherit inputs';};
  };
in {
  imports = [inputs.ags.homeManagerModules.default];
  programs.ags = {
    enable = true;
    package = pkg;
  };

  home.packages = [
    inputs'.ags-config.packages.default
    pkgs.bun
    pkgs.imagemagick
  ];
}
