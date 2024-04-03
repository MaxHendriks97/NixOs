{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./common.nix
  ];

  programs.git = {
    userEmail = "max@aqqo.com";
  };

  hyprlandLayout = "dwindle";
  hyprlandMonitor = [
    "DP-2, 1920x1080, 0x0, 1"
    "DP-3, 1920x1080, 1920x0, 1"
  ];
  hyprlandWorkspace = [
    "1, monitor:DP-2, on-created-empty:kitty, default:true"
    "2, monitor:DP-2, on-created-empty:spotify"
    "3, monitor:DP-2"
    "4, monitor:DP-2"
    "5, monitor:DP-2"
    "6, monitor:DP-3, on-created-empty:obsidian"
    "7, monitor:DP-3, on-created-empty:firefox, default:true"
    "8, monitor:DP-3, on-created-empty:beekeeper-studio"
    "9, monitor:DP-3, on-created-empty:slack"
    "10, monitor:DP-3"
  ];

  home.packages = [
    pkgs.lastpass-cli
  ];
}
