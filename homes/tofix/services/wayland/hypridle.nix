{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  lockCommand =
    if osConfig.modules.usrEnv.screenLocker == "hyprlock"
    then "${lib.getExe pkgs.hyprlock}"
    else "${lib.getExe pkgs.swaylock-effects} -f";
in {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "(pidof ${lockCommand} || ${lockCommand}) & playerctl pause -a";
        before_sleep_cmd = "loginctl lock-session";
        # Sleep 3 seconds cuz gotta wait for system to properly do what it needs to
        after_sleep_cmd = "sleep 3 && hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 120;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 180;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 300;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
