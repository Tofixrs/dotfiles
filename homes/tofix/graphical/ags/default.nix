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
    inputs'.ags-config.packages.default
    pkgs.bun
  ];
}
