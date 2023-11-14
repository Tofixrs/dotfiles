{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  hardware.acpilight.enable = true;
  services = {
    tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1;
        TLP_DEFAULT_MODE = "BAT";
        SOUND_POWER_SAVE_ON_BAT = 10;
        SOUND_POWER_SAVE_CONTROLLER = "Y";
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_TRESH_BAT_0 = 80;
        RESTORE_THRESHOLDS_ON_BAR = 1;
        NATACPI_ENABLE = 1;
        DISK_APM_LEVEL_ON_AC = "254 254";
        DISK_APM_LEVEL_ON_BAT = "128 128";
        DISK_APM_CLASS_DENYLIST = "usb ieee1394";
        WOL_DISABLE = "N";
        PLATFORM_PROFILE_ON_BAT = "balanced";
        PLATFORM_PROFILE_ON_AC = "performance";
        CPU_DRIVER_OPMODE_ON_AC = "active";
        CPU_DRIVER_OPMODE_ON_BAT = "active";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        USB_AUTOSUSPEND = 0;
      };
    };
    upower = {
      enable = true;
      percentageCritical = 5;
      percentageLow = 15;
      percentageAction = 3;
    };
    undervolt = {
      tempBat = 65;
      package = pkgs.undervolt;
    };
    acpid.enable = true;
  };
  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
  };
}
