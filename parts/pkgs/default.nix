_: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages = {
      custom-webcord = pkgs.callPackage (import ./webcord-vencord self') {};
      custom-vencord = pkgs.callPackage ./custom-vencord {};
    };
  };
}
