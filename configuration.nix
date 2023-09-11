# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")

      # My root and boot partitions
      ./sysPartitions/pc.nix

      # Choose between passthrogh the gpu or use it
      ./options/passGPU.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp9s0.useDHCP = lib.mkDefault true;

  # Apps architecture
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
  # CPU microcode
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # > NOTE
  # The past section of this config is related to my hardware, So becareful while coping that.

  # Swap
  zramSwap = {
    enable = true;
    memoryPercent = 125;
  };

  # Polkit
  security.polkit.enable = true;
  systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.lightdm.enable = true;

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 

  # USB Automounting
  services.gvfs.enable = true;
  services.devmon.enable = true;
  services.udisks2.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.assem = {
    isNormalUser = true;
    description = "Assem Mohamed";
    extraGroups = [ "networkmanager" "wheel" "kvm" "input" "disk" "libvirtd" ];
    # packages = with pkgs; [
    #   thunderbird
    # ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Sys utils
    vim
    wget
    htop
    pciutils
    neofetch
    pcmanfm
    gparted
    polkit_gnome
    obs-studio
    obsidian
    vlc
    kitty # Terminal emulator
    rofi # Application launcher most people use
    picom-next # Compositor                            
    i3blocks # Bar
    volumeicon
    networkmanagerapplet

    # Theming
    pywal
    wpgtk
    lxappearance
    qt5ct
    python311Packages.pygobject3
    gobject-introspection
    python311Packages.pillow
    python311Packages.libxslt
    libxslt
    xsettingsd
    gtk-engine-murrine
    python2Full
    wrapGAppsHook
    gtk3
 
    # Virtialization utils
    qemu
    OVMF
    virt-manager # Frontend for qemu
    looking-glass-client
    obs-studio-plugins.looking-glass-obs

    # Std utils (web browser, file manager, ...)
    pcmanfm # Lightweight file manager
    google-chrome # Browser
    
    # Dev utils
    git
    gcc # C and C++ compiler
    gdb # Debugger for C and C++
    python39 # Puthon compiler
    vscode # Lightweight test editor

    # Xorg utils
    xorg.xhost
    xorg.libXext
    xorg.libxcb
    xorg.xrdb
    lxde.lxrandr
    xrq
    libdbusmenu
    pixman
    libconfig
    libGL
    hyperscan
    libev
    uthash
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
  ];


  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
