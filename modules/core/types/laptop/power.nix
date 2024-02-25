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
