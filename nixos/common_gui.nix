{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  nixpkgs = {
    # You can add overlays here
    overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];
    # Configure your nixpkgs instance
    config = {
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
  };

  programs.nm-applet.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
      ];
      config.common = {
        default = "hyprland;gtk";
        "org.freedesktop.portal.FileChooser" = "gtk";
      };
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

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
  security.pam.services.hyprland.enableGnomeKeyring = true;

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "maxh" ];
  };

  fonts = {
    packages =
      with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        noto-fonts-extra
        liberation_ttf
        fira-code
        fira-code-symbols
        mplus-outline-fonts.githubRelease
        dina-font
        proggyfonts
        font-awesome
      ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

    fontconfig = {
      defaultFonts = {
        monospace = [ "Iosevka Nerd Font" ];
      };
    };
  };

  qt = {
    style = "adwaita";
    platformTheme = "qt5ct";
  };

  environment.systemPackages = [
    # Hyprland
    pkgs.lxqt.lxqt-policykit

    # User programs
    pkgs.firefox
    pkgs.spotify
    pkgs.nomacs
    pkgs.file-roller
    pkgs.qbittorrent
    pkgs.obsidian

    pkgs.networkmanagerapplet
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-media-tags-plugin
      thunar-archive-plugin
      thunar-volman
    ];
  };

  services.tumbler.enable = true;
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
}
