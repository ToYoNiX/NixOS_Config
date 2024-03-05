{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # Sys utils
    vim
    tree
    wget
    uget
    deluge
    neofetch
    distrobox
    qalculate-gtk
    ffmpeg-full
    cava
    obs-studio
    rnote
    nix-prefetch-git
    nix-prefetch-github
    piper
    swaybg
    lxsession
    krita
    wl-clipboard
    networkmanagerapplet

    # Std utils (web browser, file manager, ...)
    pcmanfm
    yazi
    xarchiver
    unrar
    google-chrome
    webcord
    obsidian

    # Gaming
    bottles
    lutris
    steam
    heroic
    mesa
    winePackages.waylandFull
    protontricks
    protonup-qt

    # Dev utils
    vscode-fhs
    alejandra
    gnumake
    cmake
    gcc
    gdb
    jdk
    pypy3
    python311
    mono5
  ];
}
