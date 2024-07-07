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

    mainUser = mkOption {
      type = types.nullOr types.nonEmptyStr;
      default = null;
    };
  };
}
