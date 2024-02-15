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
    xournalpp
    nix-prefetch-git
    nix-prefetch-github
    piper

    # Virtialization utils
    qemu
    OVMF
    virt-manager

    # Std utils (web browser, file manager, ...)
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
