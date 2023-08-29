_: {
  imports = [./nur.nix ./xdg.nix ./env.nix];
  home.file."Pictures/Wallpapers".source = ./Wallpapers;
  programs.home-manager.enable = true;
}
