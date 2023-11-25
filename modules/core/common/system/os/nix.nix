_: {
  nix = {
    optimise.automatic = true;
    settings = {
      trusted-users = ["root" "@wheel"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d";
    };
  };
}
