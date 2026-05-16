{osConfig, ...}: {
  imports = [
    ./themes
    ./services
    ./terminal
    ./other-apps.nix
    ./graphical
    ./xdg.nix
    ./encryption.nix
    ./i18n.nix
  ];

  home = {
    inherit (osConfig.system) stateVersion;
  };

  programs.home-manager.enable = true;
}
