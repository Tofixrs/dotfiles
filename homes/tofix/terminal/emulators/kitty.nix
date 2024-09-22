{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      name = "JetBrainsMono Nerd Font";
      size = 9.5;
    };
    themeFile = "Catppuccin-Mocha";
    settings = {
      background_opacity = "0.5";
    };
  };
}
