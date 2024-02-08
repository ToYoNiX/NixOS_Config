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

  home.packages = with pkgs; [
    xclip
    xorg.xhost
    xorg.libX11
    xorg.libxcb
    xorg.libXft
    xorg.xinit
    xorg.xinput
    xorg.libXinerama
    (dwm.overrideAttrs {
      src = inputs.suckless + "/dwm";
    })
    (dwmblocks.overrideAttrs {
      src = inputs.suckless + "/dwmblocks";
    })
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.foot}/bin/foot";
    plugins = with pkgs; [
      rofi-emoji
      rofi-calc
      rofi-file-browser
    ];
    extraConfig = {
      modi = "drun,emoji,file-browser-extended,window";
      sidebar-mode = true;
      show-icons = true;
      display-file-browser-extended = "files";
    };
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

  programs.alacritty.enable = true;

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    tray = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
  };
}
