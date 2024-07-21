{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkIf;
  dev = config.modules.device;
in {
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency];
  config = mkIf dev.hasSound {
    programs.noisetorch.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber = {
        enable = true;
        extraConfig = {
          "bluez_monitor.properties" = {
            "bluez.enable-sbc-xq" = true;
            "bluez.enable-msbc" = true;
            "bluez.enable-hw-volume" = true;
            "bluez.headset-roles" = ["hsp_hs" "hsp_ag" "hfp_fp" "hfp_ag"];
          };
        };
      };
      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
      lowLatency.enable = true;
    };
    systemd.user.services = {
      "pipewire.socket".wantedBy = ["default.target"];
    };
  };
}
