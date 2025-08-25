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
      settings = {
        profile = [
          {
            time = "6:00";
            temperature = 6500;
          }
          {
            time = "22:00";
            temperature = 3500;
          }
        ];
      };
    };
  };
}
