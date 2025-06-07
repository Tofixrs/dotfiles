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
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  hardware.sane = {
    enable = true;
    brscan4 = {
      enable = true;
      netDevices = {
        home = {
          model = "DCP-1622WE";
          ip = "192.168.0.157";
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    system-config-printer
  ];
}
