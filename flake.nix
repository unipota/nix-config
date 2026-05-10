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

    # NixOS hardware configuration
  };

  outputs =
    {
      self,
      nixpkgs,
      darwin,
      home-manager,
      ...
    }@inputs:
    let
      supportedSystems = [ "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      apps = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          update = pkgs.writeShellApplication {
            name = "darwin-update";
            runtimeInputs = [
              pkgs.git
              pkgs.nix
            ];
            text = ''
              exec ${self}/scripts/update.sh "$@"
            '';
          };
        in
        {
          update = {
            type = "app";
            program = "${update}/bin/darwin-update";
            meta.description = "Apply this nix-darwin configuration";
          };
          default = self.apps.${system}.update;
        }
      );
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);

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
            specialArgs = { inherit inputs; };

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
