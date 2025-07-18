{lib, ...}:
with lib; {
  options.modules.usrEnv = {
    desktop = mkOption {
      # adding cuz might add more in future
      type = types.enum ["Hyprland"];
      default = "Hyprland";
      description = ''
        The dekstop to use
      '';
    };

    isWayland = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Is desktop wayland
        For future use if needed
      '';
    };

    useHomeManager = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to use home manager. Needs mainUser to  be set;
      '';
    };
    screenLocker = mkOption {
      type = types.enum ["swaylock" "hyprlock"];
      description = ''What screen locker to use'';
      default = "swaylock";
    };

    mainUser = mkOption {
      type = types.nullOr types.nonEmptyStr;
      default = null;
    };

    enableVirtualization = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to add virt-manager
      '';
    };
  };
}
