{lib, ...}: {
  imports = [./themes ./services ./terminal ./other-apps.nix ./graphical ./xdg.nix ./encryption.nix ./i18n.nix];
  home = {
    username = "tofix";
    homeDirectory = "/home/tofix";
    stateVersion = lib.mkDefault "23.11";
    file."wallpaper.png".source = ./wallpaper.png;
  };
  programs.home-manager.enable = true;
}
