{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font.package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
    font.name = "JetBrainsMono Nerd Font";
    theme = "Catppuccin-Mocha";
  };
}
