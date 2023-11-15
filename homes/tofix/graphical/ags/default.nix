{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];
  programs.ags = {
    enable = true;
    extraPackages = [pkgs.libsoup_3];
  };

  home.packages = [
    pkgs.nodePackages.sass
  ];
  xdg.configFile."ags/js".source = ./config/js;
  xdg.configFile."ags/scss".source = ./config/scss;
  xdg.configFile."ags/packages.json".source = ./config/package.json;
  xdg.configFile."ags/config.js".source = ./config/config.js;
}
