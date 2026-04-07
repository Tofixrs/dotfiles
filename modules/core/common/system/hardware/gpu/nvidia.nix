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

  inherit (config.modules) device;
in {
  config = mkIf (device.gpu == "nvidia" || device.gpu == "hybrid-amd-nv") {
    services.xserver = mkMerge [
      {
        videoDrivers = ["nvidia"];
      }
    ];

    environment = {
      sessionVariables = mkMerge [
        (mkIf (device.gpu == "nvidia") {
          LIBVA_DRIVER_NAME = "nvidia";
        })

        (mkIf (device.gpu == "hybrid-amd-nv") {
          LIBVA_DRIVER_NAME = "radeonsi";
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
    boot.blacklistedKernelModules = ["nouveau"];

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
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}
