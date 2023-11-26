{
  inputs,
  inputs',
  pkgs,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];
  programs.ags = {
    enable = true;
    extraPackages = [pkgs.libsoup_3];
    configDir = inputs'.ags-config.packages.default;
  };

  home.packages = [
    pkgs.nodePackages.sass
    inputs'.ags-config.packages.default
  ];
}
