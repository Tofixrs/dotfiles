{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.ags.packages.${pkgs.system}.default
    pkgs.nodePackages.sass
  ];

  xdg.configFile."ags/css".source = ./config/css;
  xdg.configFile."ags/js".source = ./config/js;
  xdg.configFile."ags/packages.json".source = ./config/package.json;
  xdg.configFile."ags/config.js".source = ./config/config.js;
}
