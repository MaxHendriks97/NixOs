{ inputs, outputs, lib, config, pkgs, ... }: {
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      inputs.emacs.overlay

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

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.opengl.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services.blueman.enable = true;

  virtualisation.docker.enable = true;

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "docker" "docker-compose" "npm" ];
      theme = "";
    };
  };

  users.defaultUserShell = pkgs.zsh;

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
      extraGroups = [ "networkmanager" "wheel" "docker" "input" "audio" "render" ];
    };
  };


  qt = {
    style = "adwaita";
    platformTheme = "qt5ct";
  };

  environment.systemPackages = [
    # Hyprland
    pkgs.swaylock-effects 
    pkgs.swayidle 
    pkgs.wlogout 
    pkgs.swaybg
    pkgs.wayland-protocols
    pkgs.libsForQt5.qt5.qtwayland
    pkgs.libsForQt5.lightly
    pkgs.libsForQt5.qt5ct
    pkgs.qt6.qtwayland
    pkgs.gtk-engine-murrine
    pkgs.catppuccin-gtk
    pkgs.rofi-wayland 
    pkgs.mako 
    pkgs.rofimoji
    pkgs.viewnior
    pkgs.pavucontrol
    pkgs.vlc
    pkgs.sway-contrib.grimshot
    pkgs.pamixer
    pkgs.brightnessctl
    pkgs.gtk3
    pkgs.libnotify
    pkgs.poweralertd
    pkgs.dbus
    pkgs.catppuccin-kvantum
    pkgs.gnome.gnome-themes-extra
    pkgs.grim
    pkgs.playerctl
    pkgs.swaylock-effects
   
    # Home manager
    pkgs.home-manager

    # Dev tools
    pkgs.gnumake
    pkgs.cmake
    pkgs.git
    pkgs.jdk11
    pkgs.jdk17
    pkgs.nodejs
    pkgs.nixfmt
    pkgs.docker-compose
    pkgs.beekeeper-studio
    pkgs.unzip
    (pkgs.python3.withPackages(ps: with ps; [ pip ]))

    # User programs
    pkgs.firefox
    pkgs.slack
    pkgs._1password-gui
    pkgs.htop
    pkgs.neofetch
    # qgis-ltr
    pkgs.spotify
    pkgs.nomacs
    pkgs.gnome.file-roller
    pkgs.qbittorrent
    pkgs.obsidian
    
    # Ranger
    pkgs.ranger
    pkgs.w3m
    pkgs.file
    pkgs.ffmpeg
    pkgs.atool
    pkgs.poppler_utils
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
  system.stateVersion = "23.05";
}
