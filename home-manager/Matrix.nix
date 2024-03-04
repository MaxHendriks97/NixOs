{ inputs, outputs, lib, config, pkgs, nix-colors, ... }: {
  imports = [
    ./common.nix
  ];

  hyprlandLayout = "dwindle";
  hyprlandMonitor = [
    "DP-2, 1920x1080, 0x0, 1"
    "DP-3, 1920x1080, 1920x0, 1"
  ];
}
