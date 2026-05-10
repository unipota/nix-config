# Home-manager configuration for the user
{ ... }:

{
  # Automatically back up existing dotfiles managed by home-manager
  home-manager.backupFileExtension = "bak";
  home-manager.useGlobalPkgs = true;

  home-manager.users.unipota =
    { ... }:
    {
      imports = [
        ../modules/home/development.nix
        ./packages.nix
        ./shell.nix
        ./programs/git.nix
        ./programs/ghostty.nix
        ./programs/cli.nix
        ./programs/zellij.nix
      ];

      home.stateVersion = "23.11";
    };
}
