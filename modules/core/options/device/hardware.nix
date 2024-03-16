{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.modules.device = {
    cpu = mkOption {
      type = types.enum ["amd" null];
      default = null;
      description = ''
        The manifaturer/type of the primary system CPU. Determines with ucode services will be
        enabled and provides additional kernel packages
      '';
    };

    gpu = mkOption {
      type = types.enum ["nvidia" "hybrid-amd-nv" null];
      default = null;
      description = ''
        The manifaturer/type of the primary system GPU. Allows the correct GPU
        drivers to be loaded, potentially optimizing video output
      '';
    };

    monitors = mkOption {
      type = types.listOf types.str;
      default = [];
      description = ''
      '';
    };

    nvEnablePowerManagement = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable nvidia power managment";
    };
    amdBusId = mkOption {
      type = types.nullOr types.nonEmptyStr;
      default =
        if config.modules.device.gpu == "hybrid-amd-nv"
        then ""
        else null;
    };
    nvBusId = mkOption {
      type = types.nullOr types.nonEmptyStr;
      default =
        if config.modules.device.gpu == "hybrid-amd-nv"
        then ""
        else null;
    };
    wlrDRMDevice = mkOption {
      type = types.nullOr types.nonEmptyStr;
      default =
        if config.modules.device.gpu == "hybrid-amd-nv"
        then ""
        else null;
    };
  };
}
