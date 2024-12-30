# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  nixpkgs-openvpn,
  ...
}:
{
  # You can import other NixOS modules here
  networking.hosts = {
    "127.0.0.1" = [
      "crs.local"
      "app.crs.local"
      "api.crs.local"
      "login.aqqo.local"
      "hqcrs.local"
      "hqcrs2.local"
      "mdm.local"
      "parentsite.local"
      "gateway.local"
      "crs-backend-userportal-api.local"
    ];
  };

  environment.systemPackages =
    let
      myphp = pkgs.php82.buildEnv {
        extensions =
          { enabled, all }:
          enabled
          ++ [
            all.curl
            all.intl
            all.mbstring
            all.mysqli
            all.opcache
            all.xml
            all.zip
            all.ssh2
          ];
        extraConfig = "memory_limit = 5G";
      };
    in
    [
      # Aqqo Dev tools
      myphp
      myphp.packages.composer
      pkgs.yarn
      pkgs.flyway
      pkgs.mysql-workbench
      pkgs.gettext
      pkgs.onedrive
      pkgs.onedrivegui
      pkgs.openvpn
      pkgs.lastpass-cli
    ];

  programs.thunderbird = {
    enable = true;
  };
}
