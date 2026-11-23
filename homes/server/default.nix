{osConfig, ...}: {
  home.username = "server";
  home.homeDirectory = "/home/server";
  programs.home-manager.enable = true;
  services.ssh-agent.enable = true;
  home.stateVersion = osConfig.system.stateVersion;
}
