{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  nvStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;
  nvidiaPackages =
    if (versionOlder nvBeta nvStable)
    then config.boot.kernelPackages.nvidiaPackages.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;

  device = config.modules.device;
  env = config.modules.usrEnv;
in {
  config = mkIf (device.gpu == "nvidia" || device.gpu == "hybrid-amd-nv") {
    services.xserver = mkMerge [
      {
        videoDrivers = ["nvidia"];
      }
    ];
    boot.blacklistedKernelModules = ["nouveau"];

    environment = {
      sessionVariables = mkMerge [
        {
          LIBVA_DRIVER_NAME = "nvidia";
        }

        (mkIf (env.isWayland
          && device.gpu
          == "hybrid-amd-nv") {
          __NV_PRIME_RENDER_OFFLOAD = "1";
        })
      ];
      systemPackages = with pkgs; [
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        libva
        libva-utils
      ];
    };

    hardware = {
      nvidia = {
        package = mkDefault nvidiaPackages;
        modesetting.enable = true;
        prime = mkIf (device.gpu
          == "hybrid-amd-nv") {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          amdgpuBusId = device.amdBusId;
          nvidiaBusId = device.nvBusId;
        };
        powerManagement = mkIf device.nvEnablePowerManagement {
          enable = true;
          finegrained = true;
        };

        open = true;
        nvidiaSettings = false;
        nvidiaPersistenced = mkForce false;
        forceFullCompositionPipeline = true;
      };
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    };
  };
}
