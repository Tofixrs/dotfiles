{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  sys = config.modules.system;
  # Fuck hp why do you have to fuck backlight up
  params = ["acpi_backlight=native" "pti=auto"];
in {
  config = {
    boot = {
      kernelPackages = sys.boot.kernel;
      loader.efi.canTouchEfiVariables = true;
      extraModulePackages = mkDefault sys.boot.extraModulePackages;
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
