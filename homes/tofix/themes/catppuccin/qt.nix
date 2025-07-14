{pkgs, ...}: let
  themePkg = pkgs.catppuccin-kvantum.override {
    accent = "mauve";
    variant = "mocha";
  };
in {
  home.packages = [
    themePkg
  ];
  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    General.theme = "catppuccin-mocha-mauve";
  };
  xdg.configFile."Kvantum/catppuccin-mocha-mauve".source = "${themePkg}/share/Kvantum/catppuccin-mocha-mauve";
}
