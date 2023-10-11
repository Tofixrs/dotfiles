{config, ...}: {
  boot.kernelModules = ["nvidia-modeset" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    prime = {
      offload = true;
      nvidiaBusID = "PCI:1:0:0";
      amdgpuBusID = "PCI:6:0:0";
    };
    powerManagment = {
      enable = true;
      fineGrained = true; 
    };
  };
  services.xserver.videoDrivers = ["nvidia"];
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_DRM_DEVICES = "/dev/dri/card1;/dev/dri/card0";
  };
}
