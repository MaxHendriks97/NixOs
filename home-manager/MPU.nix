{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./common.nix
  ];

  programs.git = {
    userEmail = "max.hendriks1712@gmail.com";
  };

  home.packages = [
    pkgs.chuck
    pkgs.audacity
    pkgs.miniaudicle
    pkgs.protontricks
    pkgs.yabause
  ];
}
