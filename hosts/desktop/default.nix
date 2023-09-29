{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    # Choose between passthrogh the gpu or use it
    ./discreteGPU/pass.nix # OR use.nix
  ];
}
