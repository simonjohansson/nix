{
  description = "Simon macOS config with nix-darwin + home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nix-darwin, home-manager, ... }:
    let
      system = "aarch64-darwin";
      username = "simonjohansson";
      hostname = "Simons-MacBook-Pro";
      repoRoot = "/Users/${username}/src/nix";
      darwinConfiguration = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.backupFileExtension = "hm-backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home/${username}.nix;
          }
        ];
        specialArgs = {
          inherit username hostname repoRoot system;
        };
      };
    in {
      darwinConfigurations.${hostname} = darwinConfiguration;
      checks.${system}.darwin = darwinConfiguration.system;
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
    };
}
