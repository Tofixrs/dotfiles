{inputs, ...}: {
  imports = [./apps ./wms ./other inputs.qs-config.homeManagerModules.qs-config];

  programs.qs-config.enable = true;
}
