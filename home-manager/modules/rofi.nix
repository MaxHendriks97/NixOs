{ config, lib, pkgs, ... }: {
  config = {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = [
        pkgs.rofimoji
      ];
    };
  };
}
