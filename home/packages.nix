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
    btop
    deluge
    neofetch
    distrobox
    qalculate-gtk
    ffmpeg-full
    cava
    obs-studio
    rnote
    xournalpp
    nix-prefetch-git
    nix-prefetch-github
    swaybg
    lxsession
    krita
    wl-clipboard
    grim
    slurp
    swappy
    pavucontrol
    networkmanagerapplet

    # Std utils (web browser, file manager, ...)
    pcmanfm
    yazi
    xarchiver
    unrar
    google-chrome
    webcord
    obsidian

    # Engineering
    arduino

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
    python311Packages.pip
    python311Packages.ipykernel
    mono5

    # Theming with pywal
    pywal
    wpgtk
    qt5ct
    python311Packages.pygobject3
    python311Packages.pillow
    python311Packages.libxslt
    libxslt
    xsettingsd
    gtk-engine-murrine
    wrapGAppsHook
    gtk3
    nerdfonts
  ];
}
