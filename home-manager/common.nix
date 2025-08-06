# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  nix-colors,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./modules/nixvim
  ];

  colorScheme = {
    slug = "everforest";
    name = "Everforest";
    palette = {
      base00 = "272e33"; # bg0,        Default background
      base01 = "2e383c"; # bg1,        Lighter background
      base02 = "414b50"; # bg3,        Selection background
      base03 = "859289"; # grey1,      Comments
      base04 = "9da9a0"; # grey2,      Dark foreground
      base05 = "d3c6aa"; # fg,         Default foreground
      base06 = "e4e1cd"; # bg3,        Light foreground CHANGE!
      base07 = "fdf6e3"; # bg0,        Light background CHANGE!
      base08 = "7fbbb3"; # blue
      base09 = "d699b6"; # purple
      base0A = "dbbc7f"; # yellow
      base0B = "83c092"; # aqua
      base0C = "e69875"; # orange
      base0D = "a7c080"; # green
      base0E = "e67e80"; # red
      base0F = "7A8478"; # grey0
    };
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "maxh";
    homeDirectory = "/home/maxh";
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    size = 25;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "zsh";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    FLAKE = "/home/maxh/NixOs";
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "docker"
          "docker-compose"
          "npm"
        ];
        theme = "";
      };
      plugins = with pkgs; [
        {
          name = "pure";
          src = fetchFromGitHub {
            owner = "sindresorhus";
            repo = "pure";
            rev = "v1.22.0";
            sha256 = "TR4CyBZ+KoZRs9XDmWE5lJuUXXU1J8E2Z63nt+FS+5w=";
          };
          file = "pure.zsh";
        }
      ];
    };
  };
}
