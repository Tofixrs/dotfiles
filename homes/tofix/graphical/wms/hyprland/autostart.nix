{
  lib,
  inputs',
  ...
}: [
  (lib.getExe inputs'.ags-config.packages.default)
  "sleep 1 && swww init && swww img /home/tofix/wallpaper.png"
  "keepassxc"
]
