# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  nixpkgs-openvpn,
  ...
}:
{
  environment.systemPackages = [
    pkgs.groovy
    pkgs.jmeter
  ];
}
