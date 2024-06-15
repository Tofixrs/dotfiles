{osConfig, ...}: {
  imports =
    if osConfig.modules.usrEnv.isWayland
    then [./clipboard.nix ./swayidle.nix ./swaylock.nix ./gamma ./hyprlock.nix]
    else [];
}
