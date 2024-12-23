{
  pkgs,
  config,
  lib,
  ...
}: let
  app = "learning";
  domain = "${app}.example.com";
  dataDir = "/srv/http/${domain}";
in {
  users.users.${app} = {
    isSystemUser = true;
    createHome = true;
    home = dataDir;
    group = app;
    homeMode = "777";
  };
  users.groups.${app} = {};
  environment.systemPackages = with pkgs; [
    php83Packages.composer
    flatpak-builder
    distrobox
    godot_4
  ];
  services = {
    # Php server for school
    phpfpm.pools.${app} = {
      user = app;
      settings = {
        "listen.owner" = config.services.nginx.user;
        "pm" = "dynamic";
        "pm.max_children" = 32;
        "pm.max_requests" = 500;
        "pm.start_servers" = 2;
        "pm.min_spare_servers" = 2;
        "pm.max_spare_servers" = 5;
        "php_admin_value[error_log]" = "stderr";
        "php_admin_flag[log_errors]" = true;
        "catch_workers_output" = true;
        "security.limit_extensions" = false;
        "php_flag[display_errors]" = true;
      };
      phpEnv."PATH" = lib.makeBinPath [pkgs.php];
    };
    nginx = {
      enable = true;
      user = app;
      virtualHosts.${domain} = {
        root = dataDir;
        extraConfig = ''
          index index.php;
        '';
        locations = {
          "/" = {
            extraConfig = ''
              try_files $uri $uri/ =404;
              autoindex on;
            '';
          };
          "~ \\.php" = {
            extraConfig = ''
              include ${config.services.nginx.package}/conf/fastcgi_params;

              # regex to split $uri to $fastcgi_script_name and $fastcgi_path
              fastcgi_split_path_info ^(.+?\.php)(/.*)$;

              # Check that the PHP script exists before passing it
              try_files $fastcgi_script_name =404;

              # Bypass the fact that try_files resets $fastcgi_path_info
              # see: http://trac.nginx.org/nginx/ticket/321
              set $path_info $fastcgi_path_info;
              fastcgi_param PATH_INFO $path_info;

              fastcgi_index index.php;
              fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;
              include ${pkgs.nginx}/conf/fastcgi.conf;

              fastcgi_pass unix:${config.services.phpfpm.pools.${app}.socket};
              fastcgi_intercept_errors on;
              fastcgi_param SCRIPT_FILENAME $request_filename;
            '';
          };
        };
      };
    };
    mysql = {
      user = app;
      enable = true;
      package = pkgs.mariadb;
    };
    flatpak.enable = true;
  };
  systemd.services = {
    nginx.wantedBy = lib.mkForce []; #Disable nginx by default
    mysql.wantedBy = lib.mkForce []; #Disable mysql by default
    docker.wantedBy = lib.mkForce []; #Disable docker by default
    phpfpm-learning.wantedBy = lib.mkForce []; #Disable docker by default
  };
  virtualisation.docker.enable = true;
}
