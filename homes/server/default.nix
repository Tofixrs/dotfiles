{osConfig, ...}: {
  home.username = "server";
  home.homeDirectory = "/home/server";
  programs.home-manager.enable = true;
  home.stateVersion = osConfig.system.stateVersion;
}
