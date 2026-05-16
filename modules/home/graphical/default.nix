{inputs, ...}: {
  imports = [
    ./apps
    ./wms
    ./other
    ./quickshell
    inputs.qs-config.homeManagerModules.qs-config
  ];

  programs.qs-config.enable = true;
}
