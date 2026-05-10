{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.unipota.development;
in
{
  options.unipota.development = {
    enable = lib.mkEnableOption "shared development tools";

    node.enable = lib.mkEnableOption "Node.js development tools";
    rust.enable = lib.mkEnableOption "Rust development tools";
    go.enable = lib.mkEnableOption "Go development tools";

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Additional packages to add to the shared development toolset.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        # System & monitoring
        btop
        fastfetch

        # CLI utilities
        jq
        yq
        xh
        dust
        procs
        yazi
        ripgrep
        fd
        tealdeer

        # AI CLIs
        gemini-cli
        claude-code
        codex

        # Editors
        neovim

        # Development environment helpers
        devbox
      ]
      ++ lib.optionals cfg.node.enable [
        nodejs
        pnpm
      ]
      ++ lib.optionals cfg.rust.enable [
        rustc
        cargo
        rust-analyzer
      ]
      ++ lib.optionals cfg.go.enable [
        go
      ]
      ++ cfg.extraPackages;
  };
}
