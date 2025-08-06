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
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable

      inputs.nixgl.overlay

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
  };

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

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.nh.enable = true;

  programs.ssh = {
    startAgent = true;
    extraConfig = "
      ForwardAgent yes
    ";
  };

  users.users = {
    maxh = {
      isNormalUser = true;
      description = "Max Hendriks";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "input"
        "audio"
        "render"
        "storage"
        "plugdev"
        "adbusers"
        "dialout"
      ];
    };
  };

  environment.systemPackages = [
    # Home manager
    pkgs.home-manager

    pkgs.unzip

    # Dev tools
    pkgs.gnumake
    pkgs.cmake

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
    pkgs.jq
    pkgs.htop
    pkgs.neofetch
  ];
}
