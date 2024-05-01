# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
    ../common.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  systemd.user.services.onedrive = {
    enable = true;
    path = [
      pkgs.onedrive
    ];
    serviceConfig = {
      ExecStart = "onedrive --monitor --confdir='/home/maxh/.config/SharePoint_Documents'";
    };
  };

  networking.hostName = "Matrix";
  networking.hosts = {
    "127.0.0.1" = [
      "crs.local"
      "app.crs.local"
      "login.aqqo.local"
      "hqcrs.local"
      "hqcrs2.local"
      "mdm.local"
      "parentsite.local"
      "gateway.local"
      "crs-backend-userportal-api.local"
    ];
  };

  environment.systemPackages = [
    # Aqqo Dev tools
    pkgs.php82
    pkgs.php82Extensions.curl
    pkgs.php82Extensions.intl
    pkgs.php82Extensions.mbstring
    pkgs.php82Extensions.mysqli
    pkgs.php82Extensions.opcache
    pkgs.php82Extensions.xml
    pkgs.php82Extensions.zip
    pkgs.php82Extensions.ssh2
    pkgs.php82Packages.php-cs-fixer
    pkgs.php82Packages.composer
    pkgs.yarn
    pkgs.flyway
    pkgs.mysql-workbench
    pkgs.gettext
    pkgs.onedrive
  ];
}
