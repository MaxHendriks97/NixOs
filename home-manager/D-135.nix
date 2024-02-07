{ inputs, outputs, lib, config, pkgs, nix-colors, ... }: {
  imports = [
    ./common.nix
  ];

  hyprlandLayout = "dwindle";
  hyprlandMonitor = "eDP-1,2256x1504@60,0x0,1.566667";
}
