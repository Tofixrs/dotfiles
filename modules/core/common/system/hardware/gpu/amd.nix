{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  dev = config.modules.device;
in {
  config = mkIf (dev.gpu == "amd" || dev.gpu == "hybrid-amd-nv") {
    services.xserver.videoDrivers = ["amdgpu"];
    boot = {
      initrd.kernelModules = ["amdgpu"]; # load amdgpu kernel module as early as initrd
      kernelModules = ["amdgpu"]; # if loading somehow fails during initrd but the boot continues, try again later
    };

    hardware.opengl.extraPackages = with pkgs; [
      amdvlk
    ];
    # For 32 bit applications
    # Only available on unstable
    hardware.opengl.extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };
}
