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
      rev = "dad0bec1fef2833561d04ea446a544fbfde92539";
      hash = "sha256-8EEvIud5iaCWxOIkfQqOTnPUF66MwHS4sFI5yn2T6Yc=";
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
