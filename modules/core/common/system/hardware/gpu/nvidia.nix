{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  inherit (config.modules) device;
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
        # Hack to make nvidia use latest egl-wayland
        package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "560.31.02";
          sha256_64bit = "sha256-0cwgejoFsefl2M6jdWZC+CKc58CqOXDjSi4saVPNKY0=";
          sha256_aarch64 = "sha256-m7da+/Uc2+BOYj6mGON75h03hKlIWItHORc5+UvXBQc=";
          openSha256 = "sha256-X5UzbIkILvo0QZlsTl9PisosgPj/XRmuuMH+cDohdZQ=";
          settingsSha256 = "sha256-A3SzGAW4vR2uxT1Cv+Pn+Sbm9lLF5a/DGzlnPhxVvmE=";
          persistencedSha256 = "sha256-BDtdpH5f9/PutG3Pv9G4ekqHafPm3xgDYdTcQumyMtg=";
          preInstall = ''
            rm -f ./libnvidia-egl-wayland.so*
            cp ${pkgs.egl-wayland}/lib/libnvidia-egl-wayland.so.1.* .
            chmod 777 ./libnvidia-egl-wayland.so.1.*
          '';
        };
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
