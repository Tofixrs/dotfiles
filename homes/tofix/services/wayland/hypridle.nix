{
  config,
  inputs',
  osConfig,
  lib,
  pkgs,
  ...
}: let
  screenLocker = osConfig.modules.usrEnv.screenLocker;
  qs = lib.getExe inputs'.quickshell.packages.default;
  qsLockCommand = "${qs} ipc call sessionLock lock";
  lockProcess =
    if screenLocker == "hyprlock"
    then lib.getExe pkgs.hyprlock
    else lib.getExe pkgs.swaylock-effects;
  lockCommand =
    if screenLocker == "hyprlock"
    then lockProcess
    else if screenLocker == "quickshell"
    then qsLockCommand
    else "${lockProcess} -f";
  idleLockCommand =
    if screenLocker == "quickshell"
    then "${lockCommand} & playerctl pause -a"
    else "(pidof ${lockProcess} || ${lockCommand}) & playerctl pause -a";
in {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = idleLockCommand;
        before_sleep_cmd = lockCommand;
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
          on-timeout = lockCommand;
        }
        {
          timeout = 300;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
