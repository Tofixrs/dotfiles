{
  flake_path,
  pkgs,
  config,
  host,
  ...
}: {
  imports = [../base ./nvidia.nix ./hardware-configuration.nix ./syncthing.nix ./services.nix];
  programs.zsh.shellAliases.nix-switch = "sudo nixos-rebuild switch --flake ${flake_path}#${host}";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  fonts.fontconfig.defaultFonts = {
    emoji = ["Twitter Color Emoji"];
  };
  fonts.packages = with pkgs; [
    twitter-color-emoji
  ];

  services.flatpak.enable = true;

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback.out
  ];

  boot.kernelModules = [
    "v4l2loopback"
  ];

  # Set initial kernel module settings
  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

  networking.hostName = "lapfix";
}
