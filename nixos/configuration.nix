# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.framework-12th-gen-intel

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

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
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "D-135";
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

  services.fwupd.enable = true;

  services.blueman.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

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
    fonts = with pkgs; [
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
      extraGroups = [ "networkmanager" "wheel" "docker" "input" ];
    };
  };

  qt = {
    style = "adwaita";
    platformTheme = "qt5ct";
  };

  environment.systemPackages = with pkgs; [
    (neovim.override {
      vimAlias = true;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [ vim-nix ];
          opt = [];
        };
        customRc = ''
          set nocompatible
          set syntax on
          set nu
        '';
      };
    })
    # Hyprland
    swaylock-effects swayidle wlogout swaybg # Login etc
    waybar
    wayland-protocols
    libsForQt5.qt5.qtwayland
    libsForQt5.lightly
    libsForQt5.qt5ct
    qt6.qtwayland
    gtk-engine-murrine
    catppuccin-gtk
    rofi-wayland mako rofimoji # Drawer + notifications
    viewnior # Image viewer
    pavucontrol # Audio controls
    vlc
    sway-contrib.grimshot
    pamixer
    brightnessctl
    gtk3
    kitty
    libnotify
    poweralertd
    dbus
    catppuccin-kvantum
    gnome.gnome-themes-extra
    grim
    playerctl
    swaylock-effects

    # Doom emacs dependencies
    binutils
    ripgrep
    coreutils
    fd
    imagemagick
    clang
    pandoc
    shellcheck
    xorg.xwininfo
    xdotool
    xclip
    html-tidy
    nodePackages.stylelint
    nodePackages.js-beautify

    # tdlib
    gnupg
    mu
    isync
    ((emacsPackagesFor emacs-unstable-pgtk).emacsWithPackages (epkgs: [ epkgs.vterm ]))

    # Dev tools
    gnumake
    cmake
    git
    jdk11
    nodejs
    nixfmt
    docker-compose
    beekeeper-studio
    unzip
    (pkgs.python3.withPackages(ps: with ps; [ pip ]))

    # User programs
    firefox
    slack
    _1password-gui
    htop
    neofetch
    qgis-ltr
    spotify
    nomacs
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-media-tags-plugin
      thunar-archive-plugin
      thunar-volman
    ];
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

  system.autoUpgrade = {
    enable = true;
    flake = "/home/maxh/nixos-config#D-135";
    flags = [ "--recreate-lock-file" ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
