{
  pkgs,
  flake_path,
  host,
  ...
}: {
  imports = [./services.nix ./networking.nix];
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.editor = false;
    efi.canTouchEfiVariables = true;
  };
  boot.supportedFilesystems = ["ntfs"];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    builders-use-substitutes = true;
    substituters = [
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
    ];
    trusted-public-keys = [
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  nix.trustedUsers = ["root" "@wheel"];
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users.tofix = {
      isNormalUser = true;
      initialPassword = "i<3hyprland";
      extraGroups = ["wheel" "networkmanager"];
    };
  };
  environment.systemPackages = with pkgs; [
    neovim
    home-manager
    cachix
    gcc
    alejandra
  ];
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    setOptions = ["PROMPT_SUBST" "appendhistory"];
    shellAliases = {
      all-switch = "nix-switch && home-switch";
      all-update = "sudo nix flake update ${flake_path}# && all-switch";
      nix-switch = "sudo nixos-rebuild switch --flake ${flake_path}#${host}";
    };
  };
  programs.noisetorch.enable = true;
  console.keyMap = "pl2";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  system.stateVersion = "23.11";
}
