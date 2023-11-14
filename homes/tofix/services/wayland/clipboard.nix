{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  env = osConfig.modules.usrEnv;
in {
  config = mkIf (env.isWayland) {
    home.packages = with pkgs; [
      cliphist
      wl-clip-persist
      wl-clipboard
    ];
    systemd.user.services = {
      cliphist = {
        Unit.Description = "Clipboard history service";
        Service = {
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getExe pkgs.cliphist} store";
          Restart = "always";
        };
        Unit.PartOf = ["graphical-session.target"];
        Unit.After = ["graphical-session.target"];
        Install.WantedBy = ["graphical-session.target"];
      };
      wl-clip-persist = {
        Unit.Description = "Persistent clipboard for Wayland";
        Service = {
          ExecStart = "${lib.getExe pkgs.wl-clip-persist} --clipboard both";
          Restart = "always";
        };
        Unit.PartOf = ["graphical-session.target"];
        Unit.After = ["graphical-session.target"];
        Install.WantedBy = ["graphical-session.target"];
      };
    };
  };
}
