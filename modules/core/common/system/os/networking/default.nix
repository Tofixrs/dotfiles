_: {
  imports = [./ssh.nix];
  networking = {
    networkmanager.enable = true;
    nameservers = ["1.1.1.1"];
    firewall = rec {
      allowedTCPPorts = [5173];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
