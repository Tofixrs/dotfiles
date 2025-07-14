_: {
  nix = {
    optimise.automatic = true;
    settings = {
      trusted-users = ["root" "@wheel"];
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d";
    };
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.05"
  ];
}
