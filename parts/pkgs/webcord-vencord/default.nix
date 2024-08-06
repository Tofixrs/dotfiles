self': {
  # allow overriding electron
  electron,
  webcord,
  substituteAll,
}:
# nixpkgs-update: no auto update
(webcord.override {inherit electron;}).overrideAttrs (old: {
  pname = "webcord-vencord";

  patches =
    (old.patches or [])
    ++ [
      (substituteAll {
        src = ./add-extension.patch;
        vencord = self'.packages.custom-vencord;
      })
    ];

  meta = {
    inherit (old.meta) license mainProgram platforms;

    description = "Webcord with Vencord web extension";
  };
})
