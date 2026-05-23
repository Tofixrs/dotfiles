let
  caches = import ./nix/caches.nix;
in {
  nix = {
    optimise.automatic = true;
    settings = {
      substituters = caches.substituters;
      trusted-public-keys = caches.trusted-public-keys;
      trusted-users = ["root" "@wheel"];
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d";
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };
}
