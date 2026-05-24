{inputs, ...}: {
  imports = [
    ./apps
    ./wms
    ./quickshell
    inputs.qs-config.homeManagerModules.qs-config
  ];
}
