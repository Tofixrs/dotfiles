{
  buildNpmPackage,
  fetchFromGitHub,
  lib,
  esbuild,
  buildWebExtension ? true,
}: let
  version = "1.9.7";
  gitHash = "d072498";
in
  buildNpmPackage rec {
    pname = "vencord";
    inherit version;

    src = fetchFromGitHub {
      owner = "Tofixrs";
      repo = "CustomVencord";
      rev = "d072498e62441ff1c89c869b70579886868d2832";
      hash = "sha256-lATMBSy1zrKOWs3i+e3Uu1N8zMLwIWpICwmbQEssY3Y=";
      fetchSubmodules = true;
    };

    ESBUILD_BINARY_PATH = lib.getExe (esbuild.overrideAttrs (final: _: {
      version = "0.15.18";
      src = fetchFromGitHub {
        owner = "evanw";
        repo = "esbuild";
        rev = "v${final.version}";
        hash = "sha256-b9R1ML+pgRg9j2yrkQmBulPuLHYLUQvW+WTyR/Cq6zE=";
      };
      vendorHash = "sha256-+BfxCyg0KkDQpHt/wycy/8CTG6YBA/VJvJFhhzUnSiQ=";
    }));

    # Supresses an error about esbuild's version.
    npmRebuildFlags = ["|| true"];

    makeCacheWritable = true;
    npmDepsHash = "sha256-DOd7BL8QAO5pLR1xt5TfA8wE5PvzWu3HHyMC22SJxro=";
    npmFlags = ["--legacy-peer-deps"];
    npmBuildScript =
      if buildWebExtension
      then "buildWeb"
      else "build";
    npmBuildFlags = ["--" "--standalone" "--disable-updater"];

    prePatch = ''
      cp ${./package-lock.json} ./package-lock.json
      chmod +w ./package-lock.json
    '';

    VENCORD_HASH = gitHash;
    VENCORD_REMOTE = "${src.owner}/${src.repo}";

    installPhase =
      if buildWebExtension
      then ''
        cp -r dist/chromium-unpacked/ $out
      ''
      else ''
        cp -r dist/ $out
      '';

    passthru.updateScript = ./update.sh;

    meta = with lib; {
      description = "Vencord web extension";
      homepage = "https://github.com/Vendicated/Vencord";
      license = licenses.gpl3Only;
    };
  }
