{ pkgs, osConfig, ... }:
let
  theme = osConfig.modules.theme;
in {
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
    theme = {
      name = "catppuccin-${theme.flavor}-${theme.accent}-compact";
      package = pkgs.catppuccin-gtk.override {
        variant = theme.flavor;
        accents = [ theme.accent ];
        size = "compact";
      };
    };
  };
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
  };
  home.packages = with pkgs; [
    catppuccin-papirus-folders
  ];
}
