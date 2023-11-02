{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  boot = {
    # Boot Options
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        # Grub Dual Boot
        enable = true;
        devices = ["nodev"];
        efiSupport = true;

        # Find All Boot Options
        useOSProber = true;
        configurationLimit = 2;

        theme = pkgs.nixos-grub2-theme;
      };
      timeout = 3;
    };

    kernelParams = ["quiet"];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  systemd = {
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      # Import your home-manager configuration
      assem = import ../home;
    };
  };

  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # Swap
  zramSwap = {
    enable = true;
    memoryPercent = 125;
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

  hardware.pulseaudio.enable = false;
  sound.mediaKeys = {
    enable = true;
  };
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

  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
    };

    greetd = {
      enable = true;
      settings = rec {
        init_session = {
          command = "Hyprland";
          user = "assem";
        };
        default_session = init_session;
      };
    };

    # USB Automounting
    gvfs.enable = true;
    devmon.enable = true;
    udisks2.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
  };

  environment = {
    variables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };

    sessionVariables = {
      # If cursor becomes invisible
      WLR_NO_HARDWARE_CURSORS = "1";

      # Hint electron apps to use wayland
      #NIXOS_OZONE_WL = "1";

      TERMINAL = "kitty";
      VISUAL = "vim";
      EDITOR = "vim";
    };
  };

  # Virtualisation
  virtualisation = {
    libvirtd.enable = true;

    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
      # For Nixos version > 22.11
      #defaultNetwork.settings = {
      #  dns_enabled = true;
      #};
    };
  };
  programs.dconf.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.assem = {
    isNormalUser = true;
    description = "Assem Mohamed";
    extraGroups = ["networkmanager" "wheel" "video" "kvm" "input" "disk" "libvirtd"];
    # packages = with pkgs; [
    #   thunderbird
    # ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Sys utils
    tree
    wget
    htop
    btop
    sysstat
    pciutils
    starship
    lxsession
    killall
    neofetch
    pfetch
    distrobox
    appflowy
    evince
    openboard
    obs-studio
    qalculate-gtk
    libnotify
    glib
    gptfdisk
    mpv
    mpd
    yt-dlp
    ffmpeg-full
    losslesscut-bin
    cava
    ncpamixer
    networkmanagerapplet
    uget
    eza

    # Virtialization utils
    qemu
    OVMF
    virt-manager # Frontend for qemu
    looking-glass-client
    obs-studio-plugins.looking-glass-obs

    # Std utils (web browser, file manager, ...)
    pcmanfm
    xarchiver
    unrar
    google-chrome # Browser
    webcord
    libreoffice-fresh

    # Dev utils
    gcc
    gdb # C, C++ compiler and debugger
    pypy3
    python311 # Python compilers
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        ms-vscode.cpptools
        ms-python.python
        ms-python.vscode-pylance
        jnoortheen.nix-ide
        kamadorueda.alejandra
        arcticicestudio.nord-visual-studio-code
      ];
    })
    neovim # Text editors
    python311Packages.venvShellHook
    python311Packages.pip
  ];

  # Gtklock workaround
  security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override {fonts = ["Meslo"];})
    ];
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
  system.stateVersion = "23.11"; # Did you read the comment?
}
