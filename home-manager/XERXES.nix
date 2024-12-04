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
  ];

  programs.git = {
    userEmail = "max@aqqo.com";
  };

  hyprlandLayout = "dwindle";
  hyprlandMonitor = [
    "eDP-1, preferred, 960x1080, 1"
    "DP-4, preferred, 0x0, 1"
    "DP-1, preferred, 1920x0, 1"
    "Unknown-1, disable"
  ];
  hyprlandWorkspace = [
    "1, monitor:DP-4, on-created-empty:neovide, default:true"
    "2, monitor:DP-4"
    "3, monitor:DP-4"
    "4, monitor:DP-4"
    "5, monitor:eDP-1, on-created-empty:obsidian, default:true"
    "6, monitor:eDP-1, on-created-empty:spotify"
    "7, monitor:DP-1, on-created-empty:qutebrowser, default:true"
    "8, monitor:DP-1, on-created-empty:beekeeper-studio"
    "9, monitor:DP-1"
    "10, monitor:DP-1"
  ];

  home.packages = [
    pkgs.postman
    pkgs.lastpass-cli
    pkgs.teams-for-linux
    pkgs.figma-linux
  ];
}
