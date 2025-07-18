{pkgs, ...}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.tofix = {
      isNormalUser = true;
      initialPassword = "changeMe";
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "learning"
        "adbusers"
        "plugdev"
        "scanner"
        "lp"
        "libvirtd"
      ];
    };
  };
}
