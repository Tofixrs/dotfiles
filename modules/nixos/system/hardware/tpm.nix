{
  config,
  lib,
  ...
}:
with lib; let
  device = config.modules.device;
in {
  config = mkIf (device.hasTPM) {
    security.tpm2 = {
      enable = mkDefault true;
      abrmd.enable = mkDefault true;
      tctiEnvironment.enable = mkDefault true;
      pkcs11.enable = mkDefault true;
    };
  };
}
