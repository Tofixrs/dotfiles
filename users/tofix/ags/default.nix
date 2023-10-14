{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.ags.packages.${pkgs.system}.default
    pkgs.nodePackages.sass
  ];

  xdg.configFile."ags/js".source = ./config/js;
  xdg.configFile."ags/scss".source = ./config/scss;
  xdg.configFile."ags/packages.json".source = ./config/package.json;
  xdg.configFile."ags/config.js".source = ./config/config.js;
}
