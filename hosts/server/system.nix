_: {
  config.modules = {
    device = {
      cpu = "amd";
      gpu = "nvidia";
      nvEnablePowerManagement = false;
    };
    system.boot = {
       loader = "systemd-boot";
       enableKernelTweaks = true;
    };
    system.users = ["server"];
    usrEnv = {
      desktop = "none";
      isWayland = false;
      useHomeManager = true;
      screenLocker = "none";  
      mainUser = "server";
    };
  };
}
