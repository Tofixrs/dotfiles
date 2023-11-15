{pkgs, ...}: let
  autostart = pkgs.writeScript "autostart.sh" ''
    #!/usr/bin/env bash
    sleep 10

    cd ~/.config/autostart || {
      exit;
    }

    files="$(ls -1 ./*.desktop)"

    for file in $files;
    do
      $(grep '^Exec' $file | tail -1 | sed 's/^Exec=//' | sed 's/%.//' \
    | sed 's/^"//g' | sed 's/" *$//g') &
    done
  '';
in {
  systemd.user.services.autostart = {
    Service.ExecStart = autostart;
    Unit = {
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
