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
    ./discreteGPU/pass.nix # OR use.nix
  ];
}
