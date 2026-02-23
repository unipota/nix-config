# Home-manager configuration for the user
{ pkgs, ... }:

{
  # Automatically back up existing dotfiles managed by home-manager
  home-manager.backupFileExtension = "bak";

  home-manager.users.unipota =
    { config, pkgs, ... }:
    {
      imports = [
        ./packages.nix
        ./shell.nix
        ./programs/git.nix
        ./programs/ghostty.nix
        ./programs/cli.nix
        ./programs/zellij.nix
      ];

      home.stateVersion = "23.11";

      # Enable unfree packages for this user
      nixpkgs.config.allowUnfree = true;
    };
}
