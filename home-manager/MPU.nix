{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./common.nix
    ./common_gui.nix
    ./common_linux.nix
  ];

  programs.git = {
    userEmail = "max.hendriks1712@gmail.com";
  };

  hyprlandMonitor = [
    "HDMI-A-1, 3840x2160@120.00Hz, 0x0, 2"
  ];

  home.packages = [
    pkgs.protontricks
    pkgs.yabause
    pkgs.sidequest
    pkgs.megasync
  ];
}
