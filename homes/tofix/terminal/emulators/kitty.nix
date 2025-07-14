{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 9.5;
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
    settings = {
      background_opacity = "0.5";
    };
  };
}
