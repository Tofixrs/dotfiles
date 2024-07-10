{lib, ...}: {
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = lib.mkForce "no";
      PasswordAuthentication = true;
      X11Forwarding = false;
    };
  };
}
