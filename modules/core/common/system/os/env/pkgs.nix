{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    curl
    pciutils
    wget
    lshw
  ];
}
