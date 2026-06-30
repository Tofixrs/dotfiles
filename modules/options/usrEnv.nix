{lib, ...}:
with lib; {
  options.modules.usrEnv = {
    desktop = mkOption {
      # adding cuz might add more in future
      type = types.enum ["Hyprland" "none"];
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
      type = types.enum ["swaylock" "hyprlock" "quickshell" "none"];
      description = ''What screen locker to use'';
      default = "quickshell";
    };

    mainUser = mkOption {
      type = types.nonEmptyStr;
      default = "tofix";
      description = "The primary user of the system";
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
