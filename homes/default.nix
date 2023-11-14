{
  config,
  inputs,
  self,
  inputs',
  self',
  lib,
  ...
}: let
  inherit (config) modules;
  env = modules.usrEnv;
in {
  home-manager = lib.mkIf env.useHomeManager {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "old";
    extraSpecialArgs = {inherit inputs self inputs' self';};
    users = lib.genAttrs config.modules.system.users (name: ./${name});
  };
}
