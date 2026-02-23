{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- System & Monitoring ---
    btop
    fastfetch

    # --- CLI Utilities ---
    jq
    yq
    xh
    dust
    procs
    yazi
    ripgrep
    fd
    tealdeer

    # --- AI CLIs ---
    gemini-cli
    claude-code
    codex

    # --- Editors ---
    neovim

    # --- Development Environments ---
    devbox

    nodejs
    pnpm
    rustc
    cargo
    rust-analyzer
    go
  ];
}
