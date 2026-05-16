{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.system;
in {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];
  config = mkIf (cfg.boot.loader == "secure-boot") {
    boot.loader.systemd-boot.enable = mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      configurationLimit = 10;
      autoGenerateKeys.enable = true;
      autoEnrollKeys = {
        enable = true;
        autoReboot = true;
      };
      settings = {
        console-mode = mkDefault "max";
        editor = true;
      };
    };

    environment.systemPackages = [
      pkgs.sbctl
    ];
  };
}
