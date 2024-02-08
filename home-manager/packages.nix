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
    btop
    neofetch
    distrobox
    qalculate-gtk
    ffmpeg-full
    cava
    networkmanagerapplet
    obs-studio
    xournalpp
    nix-prefetch-git
    nix-prefetch-github
    pulseaudio
    feh
    lxsession
    krita
    piper

    # Virtialization utils
    qemu
    OVMF
    virt-manager

    # Std utils (web browser, file manager, ...)
    pcmanfm
    xarchiver
    unrar
    google-chrome
    discord
    obsidian

    # Gaming
    bottles
    lutris
    steam
    heroic
    mesa
    wineWowPackages.waylandFull

    # Dev utils
    gnumake
    cmake
    gcc
    gdb
    pypy3
    mono5
    python311
    python311Packages.venvShellHook
    python311Packages.pip
  ];
}
