{pkgs, ...}: {
  home.packages = with pkgs; [dconf];
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
  gtk = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font 12";
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
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  home.sessionVariables = {
    GTK_USE_PORTAL = 1;
  };
}
