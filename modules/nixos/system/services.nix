_: {
  services = {
    thermald.enable = true;
    fwupd.enable = true;
    journald.extraConfig = ''
      SystemMaxUse=100M
      RuntimeMaxUse=50M
      SystemMaxFileSize=50M
    '';
  };
}
