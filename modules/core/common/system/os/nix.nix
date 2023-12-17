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
}
