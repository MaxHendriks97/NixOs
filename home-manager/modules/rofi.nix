{ config, lib, pkgs, ... }: {
  config = {
    home.packages = [
      pkgs.rofimoji
    ];

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };
}
