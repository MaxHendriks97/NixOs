{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./common.nix
  ];

  programs.git = {
    userEmail = "max@aqqo.com";
  };

  hyprlandLayout = "dwindle";

  home.packages = [
    pkgs.lastpass-cli
  ];
}
