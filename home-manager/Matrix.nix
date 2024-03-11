{ inputs, outputs, lib, config, pkgs, nix-colors, ... }: {
  imports = [
    ./common.nix
  ];

  hyprlandLayout = "dwindle";
  hyprlandMonitor = [
    "DP-2, 1920x1080, 0x0, 1"
    "DP-3, 1920x1080, 1920x0, 1"
  ];
  hyprlandWorkspaceBind = [
    "1, DP-2"
    "2, DP-2"
    "3, DP-2"
    "4, DP-2"
    "5, DP-2"
    "6, DP-3"
    "7, DP-3"
    "8, DP-3"
    "9, DP-3"
    "0, DP-3"
  ];

  home.packages = [
    pkgs.lastpass-cli
  ];
}
