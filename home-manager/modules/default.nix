{ config, lib, pkgs, ... }: {
  imports = [
    ./waybar
    ./hyprland.nix
    ./rofi.nix
    ./nixvim
  ];
}
