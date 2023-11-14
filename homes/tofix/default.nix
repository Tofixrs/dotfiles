{lib, ...}: {
  imports = [./themes ./services];
  home = {
    username = "tofix";
    homeDirectory = "/home/tofix";
    stateVersion = lib.mkDefault "23.11";
  };
  programs.home-manager.enable = true;
}
