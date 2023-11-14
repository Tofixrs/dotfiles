{lib, ...}:
with lib; {
  options.modules.device = {
    hasBluetooth = mkOption {
      type = types.bool;
      default = false;
      description = "Does the device have bluetooth";
    };
    # For future use if needed
    hasSound = mkOption {
      type = types.bool;
      default = true;
      description = "Does the device have sound";
    };
    hasTPM = mkOption {
      type = types.bool;
      default = false;
      description = "Does the device have tmp";
    };
  };
}
