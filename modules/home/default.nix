# Home-manager configuration for the user
{ pkgs, catppuccin, ... }:

{
  # Automatically back up existing dotfiles managed by home-manager
  home-manager.backupFileExtension = "bak";

  home-manager.users.unipota =
    { config, pkgs, ... }:
    {
      imports = [
        catppuccin.homeModules.catppuccin
        ./packages.nix
        ./shell.nix
        ./programs/git.nix
        ./programs/ghostty.nix
        ./programs/cli.nix
      ];

      home.stateVersion = "23.11";
    };
}
