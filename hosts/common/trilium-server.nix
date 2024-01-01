{...}: {
  services.trilium-server.enable = true;

  # default data directory: /var/lib/trilium
  #services.trilium-server.dataDir = "/var/lib/trilium-sync-server";

  # default bind address: 127.0.0.1, port 8080
  #services.trilium-server.host = "0.0.0.0";
  #services.trilium-server.port = 12783;
}
