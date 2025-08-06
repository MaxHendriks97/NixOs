{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./common.nix
    ./common_gui.nix
    ./common_linux.nix
  ];

  programs.git = {
    userEmail = "max.hendriks1712@gmail.com";
  };

  hyprlandLayout = "dwindle";
  hyprlandMonitor = "eDP-1,2256x1504@60,0x0,1.566667";
}
