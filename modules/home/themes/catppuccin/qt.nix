{ pkgs, osConfig, ... }:
let
  theme = osConfig.modules.theme;
  variant = theme.flavor;
  accent = theme.accent;
  themePkg = pkgs.catppuccin-kvantum.override {
    inherit variant accent;
  };
  kvantumThemeName = "catppuccin-${variant}-${accent}";
in {
  home.packages = [
    themePkg
  ];
  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = kvantumThemeName;
  };
  xdg.configFile."Kvantum/${kvantumThemeName}".source = "${themePkg}/share/Kvantum/${kvantumThemeName}";
}
