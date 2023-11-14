{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.modules.system.boot = {
    enableKernelTweaks = mkEnableOption "security and performance related kernel parameters";
    enableInitrdTweaks = mkEnableOption "quality of life tweaks for the initrd stage";
    kernel = mkOption {
      type = types.raw;
      default = pkgs.linuxPackages_latest;
      description = "Kernel to use";
    };
    loader = mkOption {
      type = types.enum ["none" "grub" "systemd-boot"];
      default = "systemd-boot";
      description = "The boot loader to use";
    };
    extraModulePackages = mkOption {
      type = types.listOf types.package;
      default = with config.boot.kernelPackages; [acpi_call];
    };
    extraKernelParams = mkOption {
      type = with types; listOf str;
      default = [];
      description = "Extra kernel parameters to be added to the kernel command line.";
    };
  };
}
