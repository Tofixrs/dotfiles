{ config, ... }: {
  imports = [ ../../modules/home/common.nix ];

  home = {
    username = "tofix";
    homeDirectory = "/home/tofix";
    file."wallpaper.png".source = ../../modules/home/assets/wallpaper.png;
  };
}
