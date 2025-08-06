# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    ../common.nix
  ];

  networking.hostName = "SHODAN";

  users.users.maxh = {
    isNormalUser = true;
    home = "/home/maxh";
    description = "Max Hendriks";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  environment.systemPackages = [
    pkgs.git
    pkgs.neovim
    pkgs.home-manager
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
