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
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        PLATFORM_PROFILE_ON_BAT = "balanced";
        CPU_BOOST_ON_BAT = 1;
        WIFI_PWR_ON_BAT = "on";
        RUNTIME_PM_ON_BAT = "auto";
        PCIE_ASPM_ON_BAT = "default";
        USB_AUTOSUSPEND = 1;
        SOUND_POWER_SAVE_ON_BAT = 1;
        SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
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
