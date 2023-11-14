{lib, ...}: {
  config = {
    modules = {
      device = {
        cpu = "amd";
        gpu = "hybrid-amd-nv";
        nvBusId = "PCI:1:0:0";
        amdBusId = "PCI:6:0:0";
        monitors = ["eDP-1"];
        hasBluetooth = true;
        hasTPM = true;
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
        mainUser = "tofix";
      };
    };
  };
}
