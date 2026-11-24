{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    host = "127.0.0.1";
    port = 11434;
    openFirewall = false;

    environmentVariables = {
      OLLAMA_NUM_PARALLEL = "1";
      OLLAMA_MAX_LOADED_MODELS = "1";
      OLLAMA_CONTEXT_LENGTH = "4096";
      OLLAMA_KEEP_ALIVE = "5m";
    };
  };
}
