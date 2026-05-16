_: {
  config = {
    modules = {
      device = {
        cpu = "amd";
        gpu = "hybrid-amd-nv";
        nvBusId = "PCI:1:0:0";
        amdBusId = "PCI:6:0:0";
        monitors = ["eDP-1"];
        hasBluetooth = true;
        bluetoothSync = {
          enable = true;
          windowsMountPath = "/windows";
        };
        # TODO: setup tpm on the system
        hasTPM = false;
        nvEnablePowerManagement = true;
        wlrDRMDevice = "/dev/dri/card1:/dev/dri/card0";
      };
      system = {
        boot = {
          loader = "secure-boot";
          enableKernelTweaks = true;
        };
      };
      usrEnv = {
        isWayland = true;
        desktop = "Hyprland";
        useHomeManager = true;
        mainUser = "tofix";
        enableVirtualization = true;
      };
    };
  };
}
