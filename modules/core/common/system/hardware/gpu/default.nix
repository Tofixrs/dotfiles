{
  lib,
  config,
  ...
}:
with lib; {
  imports = [
    ./nvidia.nix
    ./amd.nix
  ];
  config = mkIf (config.modules.device.gpu
    == "hybrid-amd-nv") {
    environment.sessionVariables = {
      WLR_DRM_DEVICES = config.modules.device.wlrDRMDevice;
      AQ_DRM_DEVICES = config.modules.device.wlrDRMDevice;
    };
  };
}
