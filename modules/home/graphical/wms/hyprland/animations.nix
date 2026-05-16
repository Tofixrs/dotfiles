{lib, ...}: let
  mkAnimation = {
    leaf,
    speed,
    bezier ? null,
    spring ? null,
    style ? null,
    enabled ? true,
  }: {
    _args = [
      ({
          inherit speed leaf enabled;
        }
        // lib.optionalAttrs (bezier != null) {inherit bezier;}
        // lib.optionalAttrs (spring != null) {inherit spring;}
        // lib.optionalAttrs (style != null) {inherit style;})
    ];
  };
  mkCurve = {
    name,
    type,
    points ? null,
    mass ? null,
    stiffness ? null,
    dampening ? null,
  }: let
    # Build the curve config object based on the type
    curveConfig =
      if type == "bezier"
      then {inherit type points;}
      else if type == "spring"
      then {
        inherit
          type
          mass
          stiffness
          dampening
          ;
      }
      else throw "mkCurve: unsupported type ${type}";
  in {
    _args = [
      name
      curveConfig
    ];
  };
in {
  wayland.windowManager.hyprland.settings = {
    curve = [
      (mkCurve {
        name = "md3_standard";
        type = "bezier";
        points = [
          [0.2 0.0]
          [0.0 1.0]
        ];
      })
      (mkCurve {
        name = "md3_decel";
        type = "bezier";
        points = [
          [0.05 0.7]
          [0.1 1.0]
        ];
      })
      (mkCurve {
        name = "md3_accel";
        type = "bezier";
        points = [
          [0.3 0.0]
          [0.8 0.15]
        ];
      })
      (mkCurve {
        name = "overshot";
        type = "bezier";
        points = [
          [0.05 0.9]
          [0.1 1.1]
        ];
      })
      (mkCurve {
        name = "crazyshot";
        type = "bezier";
        points = [
          [0.1 1.5]
          [0.76 0.92]
        ];
      })
      (mkCurve {
        name = "hyprnostretch";
        type = "bezier";
        points = [
          [0.05 0.9]
          [0.1 1.0]
        ];
      })
      (mkCurve {
        name = "fluent_decel";
        type = "bezier";
        points = [
          [0.1 1.0]
          [0.0 1.0]
        ];
      })
      (mkCurve {
        name = "easeInOutCirc";
        type = "bezier";
        points = [
          [0.85 0.0]
          [0.15 1.0]
        ];
      })
      (mkCurve {
        name = "easeOutCirc";
        type = "bezier";
        points = [
          [0.0 0.55]
          [0.45 1.0]
        ];
      })
    ];
    animation = [
      (mkAnimation {
        leaf = "windows";
        speed = 3;
        bezier = "md3_decel";
        style = "popin 60%";
      })
      (mkAnimation {
        leaf = "border";
        speed = 10;
        bezier = "default";
      })
      (mkAnimation {
        leaf = "fade";
        speed = 2;
        bezier = "default";
      })
      (mkAnimation {
        leaf = "workspaces";
        speed = 3.5;
        bezier = "md3_decel";
        style = "slidevert";
      })
    ];
  };
}
