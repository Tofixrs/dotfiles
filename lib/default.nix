{
  nixpkgs,
  inputs,
  ...
}: let
  inherit (nixpkgs) lib;
  inherit (lib) foldl recursiveUpdate;

  builders = import ./builders.nix {inherit inputs lib;};

  # recursively merges two attribute sets
  mergeRecursively = lhs: rhs: recursiveUpdate lhs rhs;
in
  lib.extend (_: _: foldl mergeRecursively {} [builders])
