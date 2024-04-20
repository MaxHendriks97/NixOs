{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    hardware.url = "github:NixOs/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    hyprland.url = "github:hyprwm/Hyprland";
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, hardware, nix-colors, hyprland, nixgl, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    rec {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        D-135 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos configuration file <
            ./nixos/D-135/configuration.nix
          ];
        };
        MPU = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs outputs; };
              modules = [
                # > Our main nixos configuration file <
                ./nixos/MPU/configuration.nix
              ];
            };
        Matrix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
                # > Our main nixos configuration file <
                ./nixos/Matrix/configuration.nix
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "maxh@D-135" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs; inherit nix-colors; };
          modules = [
            hyprland.homeManagerModules.default

            # > Our main home-manager configuration file <
            ./home-manager/D-135.nix
          ];
        };
        "maxh@MPU" = home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
              extraSpecialArgs = { inherit inputs outputs; inherit nix-colors; };
              modules = [
                hyprland.homeManagerModules.default

                # > Our main home-manager configuration file <
                ./home-manager/MPU.nix
              ];
            };
        "maxh@Matrix" = home-manager.lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
              extraSpecialArgs = { inherit inputs outputs; inherit nix-colors; };
              modules = [
                hyprland.homeManagerModules.default

                # > Our main home-manager configuration file <
                ./home-manager/Matrix.nix
          ];
        };
      };
    };
}
