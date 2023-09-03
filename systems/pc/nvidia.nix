_: {
  boot.kernelModules = ["nvidia-modeset" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
  boot.blacklistedKernelModules = ["amdgpu" "nouveau"]; #fix for blank ttys
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
