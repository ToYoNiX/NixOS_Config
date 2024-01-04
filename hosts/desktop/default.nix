{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Choose between passthrogh the gpu or use it
    ./discreteGPU/use.nix # OR pass.nix

    # Enable Trilium server
    ./../common/trilium-server.nix
  ];

  services.nginx = {
    enable = true;
    virtualHosts."myNotes.com" = {
      locations."/trilium/" = {
        proxyPass = "http://127.0.0.1:8080/";
        extraConfig = ''
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection 'upgrade';
          proxy_set_header Host $host;
          proxy_cache_bypass $http_upgrade;
        '';
      };
    };
  };
}
