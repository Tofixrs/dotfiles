_: {
  config = {
    modules = {
      device = {
        cpu = "amd";
        gpu = "nvidia";
        hasBluetooth = false;
        hasTPM = false;
      };
      system = {
        boot = {
          loader = "systemd-boot";
          enableKernelTweaks = true;
        };
      };
      usrEnv = {
        isWayland = true;
        desktop = "Hyprland";
        useHomeManager = true;
      };
    };
  };
}
