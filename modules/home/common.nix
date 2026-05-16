{lib, ...}: {
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
    stateVersion = lib.mkDefault "23.11";
  };

  programs.home-manager.enable = true;
}
