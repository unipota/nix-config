# Nix packages installed system-wide
{ pkgs, ... }:

{
  # These packages are available to all users.
  environment.systemPackages = with pkgs; [
    # Core system tools
    git
    nh
    nixfmt
    nix-output-monitor
    kanata-with-cmd

    # Dev and search tools
    ripgrep # rg
    fd # fd
    fzf # fuzzy finder
    jq # json processor
    bat # cat clone with syntax highlighting
    eza # modern ls
    zoxide # smarter cd
    btop # resource monitor
    gh # github cli
  ];
}
