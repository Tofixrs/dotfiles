{
  config,
  lib,
  ...
}:
with lib; let
  device = config.modules.device;
in {
  config = mkIf (device.cpu == "amd") {
    hardware.cpu.amd.updateMicrocode = true;
    boot.kernelModules = [
      "kvm-amd"
      "amd-pstate"
    ];
  };
}
