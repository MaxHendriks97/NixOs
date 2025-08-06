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
    ./modules/hyprland.nix
    ./modules/rofi.nix
    ./modules/qutebrowser.nix
    ./modules/waybar
  ];

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
    VISUAL = "neovide";
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
  };

  # Enable home-manager and git
  programs = {
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
    pkgs.neovide
    pkgs.gimp
    pkgs.libreoffice
    pkgs.xorg.xrdb
    pkgs.signal-desktop
  ];
}
