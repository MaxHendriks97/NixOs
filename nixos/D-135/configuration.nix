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
    ../common.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  networking.hostName = "D-135";

  services.fwupd.enable = true;

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  programs = {
    steam.enable = true;
  };

  services = {
    flatpak.enable = true;
  };

  system.autoUpgrade = {
    enable = true;
    flake = "/home/maxh/nixos-config#D-135";
    flags = [ "--recreate-lock-file" ];
  };
}
