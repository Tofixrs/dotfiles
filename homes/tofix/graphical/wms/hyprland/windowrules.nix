[
  {
    name = "polkit agent";
    float = true;
    "match:class" = "^(org.kde.polkit-kde-authentication-agent-1)$";
  }
  {
    name = "steam friend list";
    size = "500 500";
    float = true;
    "match:class" = "^(steam)";
    "match:title" = "^(Friends List)$";
  }

  {
    name = "PiP zen-beta";
    size = "930 495";
    float = true;
    suppress_event = "fullscreen";
    "match:class" = ".*zen-beta.*";
    "match:title" = "^(Picture-in-Picture)$";
  }

  {
    name = "Libre office stupid default";
    suppress_event = "fullscreen";
    "match:class" = "^(libreoffice-startcenter)$";
  }
  {
    name = "steam notifs focus";
    no_initial_focus = true;
    "match:class" = "^(steam)$";
    "match:title" = "^(notificationtoasts)";
  }

  {
    name = "Keepass unlock database";
    float = true;
    "match:class" = "^(org.keepassxc.KeePassXC)$";
    "match:title" = "^(Unlock Database - KeePassXC)$";
  }

  {
    name = "Keepass passkeys";
    float = true;
    "match:class" = "^(org.keepassxc.KeePassXC)$";
    "match:title" = "^(KeePassXC - Passkey credentials)$";
  }

  {
    name = "Keepass something";
    float = true;
    "match:class" = "^(org.keepassxc.KeePassXC)$";
    "match:title" = "^(KeePassXC -  Access Request)$";
  }
]
