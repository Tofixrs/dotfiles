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
          version = "565.57.01";
          sha256_64bit = "sha256-buvpTlheOF6IBPWnQVLfQUiHv4GcwhvZW3Ks0PsYLHo=";
          sha256_aarch64 = "sha256-aDVc3sNTG4O3y+vKW87mw+i9AqXCY29GVqEIUlsvYfE=";
          openSha256 = "sha256-/tM3n9huz1MTE6KKtTCBglBMBGGL/GOHi5ZSUag4zXA=";
          settingsSha256 = "sha256-H7uEe34LdmUFcMcS6bz7sbpYhg9zPCb/5AmZZFTx1QA=";
          persistencedSha256 = "sha256-hdszsACWNqkCh8G4VBNitDT85gk9gJe1BlQ8LdrYIkg=";
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
