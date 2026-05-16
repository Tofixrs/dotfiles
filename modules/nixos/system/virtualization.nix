{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.usrEnv.enableVirtualization {
    programs.virt-manager.enable = true;

    virtualisation.libvirtd.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;
  };
}
