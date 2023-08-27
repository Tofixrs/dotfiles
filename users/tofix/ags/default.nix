{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.ags.packages.${pkgs.system}.default
    pkgs.nodePackages.sass
  ];

  xdg.configFile."ags/style/scss".source = ./config/style/scss;
  xdg.configFile."ags/layouts".source = ./config/layouts;
  xdg.configFile."ags/modules".source = ./config/modules;
  xdg.configFile."ags/packages.json".source = ./config/package.json;
  xdg.configFile."ags/config.js".source = ./config/config.js;
}
