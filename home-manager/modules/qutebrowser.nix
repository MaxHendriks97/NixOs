{ config, lib, pkgs, ... }: {
  config = {
    programs.qutebrowser = {
      enable = true;
    };
  };
}
