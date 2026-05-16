{
  config,
  lib,
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
  };
}
