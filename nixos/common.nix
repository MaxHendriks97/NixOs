{ inputs, outputs, lib, config, pkgs, ... }: {
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      inputs.nixgl.overlay

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;

  # select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  time.timeZone = "Europe/Amsterdam";

  # Enable CUPS to print documents
  services.printing.enable = true;

  services.nscd.enableNsncd = true;

  #services.fwupd.enable = true;

  services.gnome.gnome-keyring.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
  '';

  hardware.opengl = {
    enable = true;
    extraPackages = [
      pkgs.libGL
    ];
    setLdLibraryPath = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
      ];
      config.common.default = "*";
    };
    mime = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "thunar.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "image/png" = "nomacs.desktop";
      };
    };
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
  security.pam.services.hyprland.enableGnomeKeyring = true;

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    input.General.ClassicBondedOnly = false;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services.blueman.enable = true;

  virtualisation.docker.enable = true;

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "maxh" ];
  };

  programs.nh.enable = true;
  programs.nix-ld.enable = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      nerdfonts
      font-awesome
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Iosevka Nerd Font" ];
      };
    };
  };

  users.users = {
    maxh = {
      isNormalUser = true;
      description = "Max Hendriks";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [ "networkmanager" "wheel" "docker" "input" "audio" "render" "storage" "plugdev" ];
    };
  };


  qt = {
    style = "adwaita";
    platformTheme = "qt5ct";
  };

  environment.systemPackages = [
    # Home manager
    pkgs.home-manager

    # Hyprland
    pkgs.lxqt.lxqt-policykit

    # Java 8
    pkgs.jre8
    pkgs.glxinfo
    pkgs.nixgl.nixGLIntel

    # Dev tools
    pkgs.gnumake
    pkgs.cmake
    pkgs.jdk11
    pkgs.jdk17
    pkgs.nodejs
    pkgs.nixfmt-rfc-style
    pkgs.docker-compose
    pkgs.unzip
    (pkgs.python3.withPackages(ps: with ps; [ pip ]))
    pkgs.libxml2

    # Ranger
    pkgs.ranger
    pkgs.w3m
    pkgs.file
    pkgs.ffmpeg
    pkgs.atool
    pkgs.poppler_utils

    # Neovim dependencies
    pkgs.ripgrep

    # User programs
    pkgs.firefox
    pkgs.jq
    pkgs.slack
    pkgs.htop
    pkgs.neofetch
    # qgis-ltr
    pkgs.spotify
    pkgs.nomacs
    pkgs.gnome.file-roller
    pkgs.qbittorrent
    pkgs.obsidian

    # Windows emulation
    pkgs.wine
    pkgs.bottles
  ];

  programs.dconf.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-media-tags-plugin
      thunar-archive-plugin
      thunar-volman
    ];
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
