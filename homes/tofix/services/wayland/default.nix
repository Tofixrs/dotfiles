{osConfig, ...}: {
  imports =
    if osConfig.modules.usrEnv.isWayland
    then [./clipboard.nix ./hypridle.nix ./gamma ./hyprlock.nix ./swaylock.nix]
    else [];
}
