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
          "10-bluez-config" = {
            "monitor.bluez.properties" = {
              "bluez5.enable-sbc-xq" = true;
              "bluez5.enable-msbc" = true;
              "bluez5.enable-hw-volume" = true;
              "bluez5.roles" = ["a2dp_sink" "a2dp_source" "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
            };
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
