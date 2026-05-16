{pkgs, config, ...}: let
  user = config.modules.usrEnv.mainUser;
in {
  users = {
    defaultUserShell = pkgs.nushell;
    users."${user}" = {
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
