{lib, ...}: {
  imports = [./themes ./services ./terminal ./other-apps.nix ./graphical ./xdg.nix ./encryption.nix];
  home = {
    username = "tofix";
    homeDirectory = "/home/tofix";
    stateVersion = lib.mkDefault "23.11";
    file."wallpaper.png".source = ./wallpaper.png;
  };
  programs.home-manager.enable = true;
}
