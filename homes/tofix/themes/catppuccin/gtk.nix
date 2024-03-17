{pkgs, ...}: {
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
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = ["pink"];
        size = "compact";
      };
    };
  };
  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
  };
}
