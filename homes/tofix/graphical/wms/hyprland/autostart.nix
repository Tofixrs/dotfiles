{
  lib,
  inputs',
  ...
}: [
  (lib.getExe inputs'.ags-config.packages.default)
  "sleep 1 && swww-daemon & sleep 1 && swww img /home/tofix/wallpaper.png"
]
