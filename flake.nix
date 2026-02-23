{
  description = "unipota's Nix Darwin Configuration";

  inputs = {
    # Package repositories
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # macOS system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # User-level package and dotfile management
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Catppuccin theme
    catppuccin.url = "github:catppuccin/nix";

  };

  outputs =
    {
      self,
      nixpkgs,
      darwin,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    {
      darwinConfigurations."macbook_air" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        # Pass inputs to modules
        specialArgs = { inherit inputs catppuccin; };

        modules = [
          # Import the host-specific configuration
          ./hosts/macbook_air

          # Integrate home-manager
          home-manager.darwinModules.home-manager
        ];
      };

      apps.${"aarch64-darwin"}.update = {
        type = "app";
        program = toString (
          nixpkgs.legacyPackages.${"aarch64-darwin"}.writeShellScript "update-script" (
            builtins.readFile ./config/update.sh
          )
        );
      };
    };
}
