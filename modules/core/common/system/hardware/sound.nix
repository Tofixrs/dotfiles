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
  config = mkIf (dev.hasSound) {
    sound = {
      enable = true;
      mediaKeys.enable = true;
      mediaKeys.volumeStep = "5%";
    };

    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;

      alsa = {
        enable = true;
      };
      lowLatency.enable = true;
    };
    environment.etc = mkIf (config.services.pipewire.enable && dev.hasBluetooth) {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
          ["bluez5.enable-sbc-xq"] = true,
          ["bluez5.enable-msbc"] = true,
          ["bluez5.enable-hw-volume"] = true,
          ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '';
    };
    systemd.user.services = {
      pipewire.wantedBy = ["default.target"];
      pipewire-pulse.wantedBy = ["default.target"];
    };
  };
}
