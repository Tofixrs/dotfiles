{
  flake_path,
  pkgs,
  ...
}: {
  imports = [../base ./nvidia.nix ./hardware-configuration.nix];
  programs.zsh.shellAliases.nix-switch = "sudo nixos-rebuild switch --flake ${flake_path}#tofipc";

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

  networking.hostName = "tofipc";
}
