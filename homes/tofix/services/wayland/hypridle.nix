_: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 60;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 30;
          on-timeout = "loginctl lock-session";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 180;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
