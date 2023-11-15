{lib, ...}: {
  imports = [./themes ./services ./terminal ./other-apps.nix ./graphical];
  home = {
    username = "tofix";
    homeDirectory = "/home/tofix";
    stateVersion = lib.mkDefault "23.11";
  };
  programs.home-manager.enable = true;
}
