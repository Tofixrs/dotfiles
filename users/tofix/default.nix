{flake_path, ...}: {
  imports = [./wayland ./themes ./programs ./ags ../base ./defaultApps.nix ./env.nix];

  home.shellAliases = {
    home-switch = "home-manager switch --flake ${flake_path}#tofix";
  };

  home.username = "tofix";
  home.homeDirectory = "/home/tofix";
  home.stateVersion = "22.11";
}
