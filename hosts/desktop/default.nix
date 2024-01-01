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
}
