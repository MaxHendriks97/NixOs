{ inputs, outputs, lib, config, pkgs, nix-colors, ... }: {
  imports = [
    ./common.nix
  ];

  services.megasync.enable = true;
}
