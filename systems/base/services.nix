{
  lib,
  pkgs,
  ...
}: {
  services = {
    gvfs = {
      enable = true;
      package = lib.mkForce pkgs.gnome3.gvfs;
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
    printing.enable = true;
    printing.drivers = with pkgs; [
      brlaser
    ];
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
  security.pam.services.swaylock = {
    #Swaylock fix for wrong password
    text = ''
      auth include login
    '';
  };
  services.syncthing = {
    enable = true;
    dataDir = "/home/tofix";
    openDefaultPorts = false;
    configDir = "/home/tofix/.config/";
    user = "tofix";
    group = "users";
    guiAddress = "127.0.0.1:8384";
    overrideDevices = true;
    settings = {
      devices = {
        "phone" = {id = "HPGIQKI-GP4ZZKP-AUNHD3N-GLFQ3LC-IULR2KK-M7PLFRO-EHGY7XA-QU3OVQU";};
      };
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  programs.system-config-printer.enable = true;
}
