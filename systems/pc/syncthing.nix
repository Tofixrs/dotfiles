_: {
    services.syncthing = {
    enable = true;
    dataDir = "/home/tofix";
    openDefaultPorts = false;
    configDir = "/home/tofix/.config/syncthing";
    user = "tofix";
    group = "users";
    guiAddress = "127.0.0.1:8384";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "phone" = {id = "HPGIQKI-GP4ZZKP-AUNHD3N-GLFQ3LC-IULR2KK-M7PLFRO-EHGY7XA-QU3OVQU";};
      };
      folders = {
        "keepass" = {
          path = "/home/tofix/Documents/keepass";
          devices = ["phone"];
        };
      };
    };
  };
}
