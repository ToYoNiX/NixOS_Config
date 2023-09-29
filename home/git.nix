{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "ToYoNiX";
    userEmail = "toyonix.assemmohamed.2005@gmail.com";
  };
}
