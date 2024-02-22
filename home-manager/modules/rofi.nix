{ config, lib, pkgs, ... }: {
  config = {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = "~/NixOs/home-manager/modules/rofi/deathemonic/config/launcher.rasi";
      plugins = [
        pkgs.rofimoji
      ];
    };
  };
}
