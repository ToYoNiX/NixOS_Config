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
    qbittorrent
    btop
    neofetch
    distrobox
    qalculate-gtk
    libnotify
    glib
    gptfdisk
    ffmpeg-full
    cava
    networkmanagerapplet
    obs-studio
    xournalpp
    nix-prefetch-git
    nix-prefetch-github
    pulseaudio
    swaybg
    lxsession
    krita
    wl-clipboard

    # Std utils (web browser, file manager, ...)
    pcmanfm
    xarchiver
    unrar
    google-chrome
    webcord
    obsidian

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
