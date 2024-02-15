{
  inputs,
  outputs,
  vars,
  stylix,
  lib,
  config,
  pkgs,
  ...
}: {
  services.gnome-keyring.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      name = "Zafiro-icons-Dark";
      package = pkgs.zafiro-icons;
    };
  };

  qt = {
    enable = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
      ms-python.python
      ms-python.vscode-pylance
      jnoortheen.nix-ide
      kamadorueda.alejandra
    ];
    userSettings = {
      "terminal.integrated.enableMultiLinePasteWarning" = false;
      "workbench.startupEditor" = "none";
      "explorer.confirmDragAndDrop" = false;
    };
  };
}
