{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./common.nix
  ];

  programs.git = {
    userEmail = "max.hendriks1712@gmail.com";
  };

  services.megasync.enable = true;

  home.packages = [
    pkgs.chuck
  ];
}
