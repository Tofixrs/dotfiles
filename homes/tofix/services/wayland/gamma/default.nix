{
  osConfig,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  env = osConfig.modules.usrEnv;
in {
  config = mkIf (env.desktop == "Hyprland") {
    services.hyprsunset = {
      enable = true;
      transitions = {
        sunrise = {
          calendar = "*-*-* 06:00:00";
          requests = [
            ["temperature" "6500"]
          ];
        };
        sunset = {
          calendar = "*-*-* 22:00:00";
          requests = [
            ["temperature" "3500"]
          ];
        };
      };
    };
  };
}
