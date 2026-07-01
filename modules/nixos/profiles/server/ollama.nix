{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    models = "/models/ollama";
    host = "0.0.0.0";
    openFirewall = true;
  };

  services.open-webui = {
    enable = true;
    host = "0.0.0.0";
    port = 8080;
    openFirewall = true;
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
    };
  };

  systemd.services.ollama = {
    after = [ "models.mount" ];
    requires = [ "models.mount" ];
    serviceConfig.ExecStartPre = [
      "+${pkgs.coreutils}/bin/mkdir -p /models/ollama"
      "+${pkgs.coreutils}/bin/chown ollama:ollama /models/ollama"
      "+${pkgs.coreutils}/bin/chmod 750 /models/ollama"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /models/ollama 0750 ollama ollama - -"
  ];
}
