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
  nixpkgs = {
    config = {
      permittedInsecurePackages = [
        "freeimage-unstable-2021-11-01"
        "nix-2.16.2"
      ];
    };
  };

  home.packages = [
    pkgs.rustc
    pkgs.cargo
  ];

  programs = {
    zsh = {
      initExtra = "
        export PATH=$PATH:$HOME/bin/
        neofetch
      ";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
