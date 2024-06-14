{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  env = osConfig.modules.usrEnv;
  wl-pasteCmd = "${pkgs.wl-clipboard}/bin/wl-paste";
  cliphistCmd = "${lib.getExe pkgs.cliphist}";
in {
  config = mkIf env.isWayland {
    home.packages = with pkgs; [
      cliphist
      wl-clip-persist
      wl-clipboard
    ];
    systemd.user.services = {
      cliphist = {
        Service = {
          ExecStart = "${pkgs.writeShellScript "cliphist.sh" ''
            ${wl-pasteCmd} --type text --watch ${cliphistCmd} store &
            ${wl-pasteCmd} --type image --watch ${cliphistCmd} store
          ''}";
          Restart = "always";
        };
        Unit = {
          Description = "Clipboard history service";
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
        };
        Install.WantedBy = ["graphical-session.target"];
      };
      wl-clip-persist = {
        Service = {
          ExecStart = "${lib.getExe pkgs.wl-clip-persist} --clipboard both";
          Restart = "always";
        };
        Unit = {
          Description = "Persistent clipboard for Wayland";
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
        };
        Install.WantedBy = ["graphical-session.target"];
      };
    };
  };
}
