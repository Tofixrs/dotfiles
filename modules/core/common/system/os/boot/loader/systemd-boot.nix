{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system;
in {
  config = mkIf (cfg.boot.loader
    == "systemd-boot") {
    boot.loader.systemd-boot = {
      enable = mkDefault true;
      configurationLimit = 10;
      consoleMode = mkDefault "max";
      editor = false;
    };
  };
}
