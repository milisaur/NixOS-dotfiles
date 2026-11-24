{
  services.open-webui = {
    enable = true;
    host = "127.0.0.1";
    port = 8080;

    environment = {
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      ENABLE_OPENAI_API = "False";
      SCARF_NO_ANALYTICS = "True";
      DO_NOT_TRACK = "True";
      ANONYMIZED_TELEMETRY = "False";
    };
  };
}
