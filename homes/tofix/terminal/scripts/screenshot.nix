{lib,inputs', pkgs}: let 
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  grimblast = lib.getExe inputs'.hyprland-contrib.packages.grimblast;
  swappy = "${pkgs.swappy}/bin/swappy";
in pkgs.writeShellScriptBin "screenshot" ''
    SCREENSHOTS="$HOME/Pictures/Screenshots"
    NOW=$(date +%Y-%m-%d_%H-%M-%S)
    TARGET="$SCREENSHOTS/$NOW.png"

    mkdir -p $SCREENSHOTS
    ${grimblast} --freeze copysave $1 $TARGET

     RES=$(${notify-send} \
        -a "Screenshot" \
        -i "image-x-generic-symbolic" \
        -h string:image-path:$TARGET \
        -A "file=Show in Files" \
        -A "view=View" \
        -A "edit=Edit" \
        "Screenshot Taken" \
        $TARGET)

    case "$RES" in
        "file") $FILE_MANAGER "$SCREENSHOTS" ;;
        "view") xdg-open $TARGET ;;
        "edit") ${swappy} -f $TARGET ;;
        *) ;;
    esac

  ''
