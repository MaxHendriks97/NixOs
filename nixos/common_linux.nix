{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  nix = {
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

  services = {
    # Enable CUPS to print documents
    printing.enable = true;
    nscd.enableNsncd = true;
    #fwupd.enable = true;
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    udev.extraRules = ''
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
    '';
    flatpak.enable = true;
  };

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  security.polkit.enable = true;

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

  programs._1password.enable = true;

  programs.nix-ld.enable = true;

  environment.systemPackages = [
    # Dev tools
    pkgs.jre8
    pkgs.glxinfo
    pkgs.nixgl.nixGLIntel
    pkgs.jdk11
    pkgs.jdk17
    pkgs.docker-compose
    (pkgs.python3.withPackages (ps: with ps; [ pip ]))
    pkgs.libxml2

    # Windows emulation
    pkgs.wine
    pkgs.bottles
  ];

  programs.dconf.enable = true;

  services.gvfs.enable = true;
}
