{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  inherit (config.modules) device;
  env = config.modules.usrEnv;
  fbdev_linux_611_patch = pkgs.fetchpatch {
    url = "https://patch-diff.githubusercontent.com/raw/NVIDIA/open-gpu-kernel-modules/pull/692.patch";
    hash = "sha256-OYw8TsHDpBE5DBzdZCBT45+AiznzO9SfECz5/uXN5Uc=";
  };
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
          version = "560.35.03";
          sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
          sha256_aarch64 = "sha256-s8ZAVKvRNXpjxRYqM3E5oss5FdqW+tv1qQC2pDjfG+s=";
          openSha256 = "sha256-/32Zf0dKrofTmPZ3Ratw4vDM7B+OgpC4p7s+RHUjCrg=";
          settingsSha256 = "sha256-kQsvDgnxis9ANFmwIwB7HX5MkIAcpEEAHc8IBOLdXvk=";
          persistencedSha256 = "sha256-E2J2wYYyRu7Kc3MMZz/8ZIemcZg68rkzvqEwFAL3fFs=";
          patchesOpen = [fbdev_linux_611_patch];
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
