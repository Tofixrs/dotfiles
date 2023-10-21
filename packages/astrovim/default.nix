{
  lib,
  stdenv,
  pkgs,
  ...
}: let
  user = ./user;
in
  stdenv.mkDerivation rec {
    pname = "astrovim";
    version = "";

    src = pkgs.fetchFromGitHub {
      owner = "AstroNvim";
      repo = "AstroNvim";
      rev = "8e1b444a48591c8e3e65b9a01bb34064ed42dcb4";
      hash = "sha256-+RUxvQxPpyrJFV/toRPauDAmyyVxpqSjHCxtFuw0qA8=";
    };
    installPhase = ''
      mkdir -p "$out/"
      cp -r * "$out/"
      mkdir -p "$out/lua/user"
      cp -r ${user}/* "$out/lua/user/"
    '';

    meta = with lib; {
      description = "AstroNvim";
      homepage = "https://github.com/AstroNvim/AstroNvim";
      platforms = platforms.all;
      maintainers = [maintainers.tofix];
      license = licenses.gpl3;
    };
  }
