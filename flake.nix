{
  description = "unipota's Nix Config";

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
      darwinConfigurations =
        let
          # Read all entries in the hosts directory
          entries = builtins.readDir ./hosts;
          # Filter for directories that are not "default"
          hostDirs = builtins.attrNames (
            nixpkgs.lib.filterAttrs (name: type: type == "directory" && name != "default") entries
          );
        in
        nixpkgs.lib.genAttrs hostDirs (
          host:
          let
            system = "aarch64-darwin";
          in
          darwin.lib.darwinSystem {
            inherit system;

            # Pass inputs to modules
            specialArgs = { inherit inputs catppuccin; };

            modules = [
              # Import the host-specific configuration
              ./hosts/${host}

              # Integrate home-manager
              home-manager.darwinModules.home-manager
            ];
          }
        );
    };
}
