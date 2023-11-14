{
  config,
  lib,
  ...
}:
with lib; let
  dev = config.modules.device;
in {
  config = mkIf (dev.hasBluetooth) {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          JustWorksRepairing = "always";
          MultiProfile = "multiple";
        };
      };
    };

    services.blueman.enable = true;
  };
}
