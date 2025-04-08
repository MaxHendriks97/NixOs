# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  nix-colors,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./modules
  ];

  colorScheme = {
    slug = "everforest";
    name = "Everforest";
    palette = {
      base00 = "272e33"; # bg0,        Default background
      base01 = "2e383c"; # bg1,        Lighter background
      base02 = "414b50"; # bg3,        Selection background
      base03 = "859289"; # grey1,      Comments
      base04 = "9da9a0"; # grey2,      Dark foreground
      base05 = "d3c6aa"; # fg,         Default foreground
      base06 = "e4e1cd"; # bg3,        Light foreground CHANGE!
      base07 = "fdf6e3"; # bg0,        Light background CHANGE!
      base08 = "7fbbb3"; # blue
      base09 = "d699b6"; # purple
      base0A = "dbbc7f"; # yellow
      base0B = "83c092"; # aqua
      base0C = "e69875"; # orange
      base0D = "a7c080"; # green
      base0E = "e67e80"; # red
      base0F = "7A8478"; # grey0
    };
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "freeimage-unstable-2021-11-01"
        "nix-2.16.2"
      ];
    };
  };

  home = {
    username = "maxh";
    homeDirectory = "/home/maxh";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  gtk = {
    enable = true;
    font.name = "Iosevka";
    theme = {
      name = "Catppuccin-Mocha-Compact-Green-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "green" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    size = 25;
  };

  home.sessionVariables = {
    BROWSER = "firefox";
    TERMINAL = "kitty";
    EDITOR = "nvim";
    VISUAL = "neovide";
    SHELL = "zsh";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    CLUTTER_BACKEND = "wayland";
    #XDG_SESSION_TYPE = "wayland";
    #XDG_CURRENT_DESKTOP = "Hyprland";
    #XDG_SESSION_DESKTOP = "Hyprland";
    #GTK_USE_PORTAL = "1";
    #NIXOS_XDG_OPEN_USE_PORTAL = "1";
    #XDG_CACHE_HOME = "\${HOME}/.cache";
    #XDG_CONFIG_HOME = "\${HOME}/.config";
    #XDG_BIN_HOME = "\${HOME}/.local/bin";
    #XDG_DATA_HOME = "\${HOME}/.local/share";
    FLAKE = "/home/maxh/NixOs";
  };

  # Enable home-manager and git
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      ignores = [
        "*.phpactor.json"
        "DevUtils.php"
      ];
      userName = "Max Hendriks";
    };
    lazygit.enable = true;
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "docker"
          "docker-compose"
          "npm"
        ];
        theme = "";
      };
      plugins = with pkgs; [
        {
          name = "pure";
          src = fetchFromGitHub {
            owner = "sindresorhus";
            repo = "pure";
            rev = "v1.22.0";
            sha256 = "TR4CyBZ+KoZRs9XDmWE5lJuUXXU1J8E2Z63nt+FS+5w=";
          };
          file = "pure.zsh";
        }
      ];
      initExtra = "
        export PATH=$PATH:$HOME/bin/
        neofetch
      ";
    };
    kitty = {
      enable = true;
      settings = {
        background = "#${config.colorScheme.palette.base00}";
        foreground = "#${config.colorScheme.palette.base05}";
        background_opacity = "0.8";
      };
    };
  };

  home.packages = [
    pkgs.beekeeper-studio
    pkgs.nixd
    pkgs.neovide
    pkgs.rustc
    pkgs.cargo
    pkgs.gimp
    pkgs.libreoffice
    pkgs.xorg.xrdb
    pkgs.signal-desktop
    inputs.zen-browser.packages.x86_64-linux.default
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
