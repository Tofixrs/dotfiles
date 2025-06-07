{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  sys = config.modules.system;
  # Fuck hp why do you have to fuck backlight up
  params = ["pti=auto" "amdgpu.amblevel=0"];
in {
  config = {
    boot = {
      kernelPackages = sys.boot.kernel;
      loader.efi.canTouchEfiVariables = true;
      extraModulePackages = mkDefault (sys.boot.extraModulePackages ++ [config.boot.kernelPackages.v4l2loopback]);
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
      kernelParams = optionals sys.boot.enableKernelTweaks params;
      initrd = mkMerge [
        (mkIf sys.boot.enableInitrdTweaks {
          systemd.strip = true;
          kernelModules = [
            "nvme"
            "xhci_pci"
            "ahci"
            "btrfs"
            "sd_mod"
            "dm_mod"
            "tpm"
            "v4l2loopback"
          ];
          availableKernelModules = [
            "usbhid"
            "sd_mod"
            "dm_mod"
            "uas"
            "usb_storage"
          ];
        })
      ];
      plymouth = {
        enable = true;
        theme = "catppuccin-macchiato";
        themePackages = [pkgs.catppuccin-plymouth];
      };
    };
  };
}
