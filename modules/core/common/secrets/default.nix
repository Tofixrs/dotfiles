{inputs, ...}: let
  inherit (inputs) self;
in {
  age.secrets = {
    ags-config = {
      file = "${self}/secrets/ags-config.age";
      path = "/home/tofix/.config/ags-config/config.json";
      owner = "tofix";
    };
  };
}
