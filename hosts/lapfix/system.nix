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
        # TODO: setup tpm on the system
        hasTPM = false;
        nvEnablePowerManagement = true;
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
    hardware.nvidia.open = false;
  };
}
