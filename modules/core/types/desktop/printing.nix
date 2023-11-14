{pkgs, ...}: {
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        brlaser
      ];
    };
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
  };
}
