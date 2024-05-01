# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-pc-hdd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
    ../common.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  networking.hostName = "MPU";

  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
    "video=DP-3:3440x1440@144"
  ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = [
    pkgs.prismlauncher
    pkgs.php83
    pkgs.php83Extensions.curl
    pkgs.php83Extensions.intl
    pkgs.php83Extensions.mbstring
    pkgs.php83Extensions.mysqli
    pkgs.php83Extensions.opcache
    pkgs.php83Extensions.xml
    pkgs.php83Extensions.zip
    pkgs.php83Extensions.ssh2
    pkgs.php83Packages.php-cs-fixer
    pkgs.php83Packages.composer
    pkgs.php83Packages.php-cs-fixer
  ];

  programs = {
    steam.enable = true;
  };

  services = {
    flatpak.enable = true;
  };

}
