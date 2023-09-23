{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font.package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
    font.name = "JetBrainsMono Nerd Font";
    font.size = 9.5;
    theme = "Catppuccin-Mocha";
  };
}
