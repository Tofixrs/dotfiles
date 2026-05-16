{
  lib,
  osConfig,
  ...
}: let
  env = osConfig.modules.usrEnv;
in {
  config = lib.mkIf (env.desktop == "Hyprland") {
    wayland.windowManager.hyprland.settings.window_rule = [
      {
        match = {class = "^(org.kde.polkit-kde-authentication-agent-1)$";};
        float = true;
      }
      {
        match = {
          class = "^(steam)$";
          title = "^(Friends List)$";
        };
        float = true;
        size = [500 500];
      }
      {
        match = {
          class = ".*zen-beta.*";
          title = "^(Picture-in-Picture)$";
        };
        float = true;
        size = [930 495];
        suppress_event = "fullscreen";
      }
      {
        match = {class = "^(libreoffice-startcenter)$";};
        suppress_event = "fullscreen";
      }
      {
        match = {
          class = "^(steam)$";
          title = "^(notificationtoasts)";
        };
        no_initial_focus = true;
      }
      {
        match = {
          class = "^(org.keepassxc.KeePassXC)$";
          title = "^(Unlock Database - KeePassXC)$";
        };
        float = true;
      }
      {
        match = {
          class = "^(org.keepassxc.KeePassXC)$";
          title = "^(KeePassXC - Passkey credentials)$";
        };
        float = true;
      }
      {
        match = {
          class = "^(org.keepassxc.KeePassXC)$";
          title = "^(KeePassXC -  Access Request)$";
        };
        float = true;
      }
    ];
  };
}
