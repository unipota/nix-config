{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Modern environment essentials ---
    neovim
    jq
    btop
    gemini-cli
    fastfetch

    # --- CLI Tools (New) ---
    yq
    xh
    dust
    procs

    # --- Development Environments ---
    nodejs
    pnpm
    rustc
    cargo
    rust-analyzer
    go
  ];
}
