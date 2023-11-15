{pkgs}: [
  "hyprctl setcursor Bibata-Modern-Classic 12"
  "wl-paste --type text --watch cliphist store"
  "wl-paste --type image --watch cliphist store"
  # Possiby turn this into a wayland service
  "ags"
  "sleep 5 && swww init && swww img /home/tofix/wallpaper.jpg"
]
