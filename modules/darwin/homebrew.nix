{ config, lib, ... }:

let
  cfg = config.unipota.homebrew;
in
{
  options.unipota.homebrew = {
    enable = lib.mkEnableOption "shared Homebrew packages";

    autoUpdate = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether Homebrew updates itself during darwin-rebuild activation.";
    };

    cleanup = lib.mkOption {
      type = lib.types.enum [
        "none"
        "zap"
        "uninstall"
      ];
      default = "uninstall";
      description = "How nix-darwin should clean Homebrew packages on activation.";
    };

    core.enable = lib.mkEnableOption "core Homebrew command-line tools";
    browsers.enable = lib.mkEnableOption "browser applications";
    communication.enable = lib.mkEnableOption "communication applications";
    development.enable = lib.mkEnableOption "development applications";
    ai.enable = lib.mkEnableOption "AI applications";
    productivity.enable = lib.mkEnableOption "productivity applications";
    utilities.enable = lib.mkEnableOption "system utility applications";

    extraTaps = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Additional Homebrew taps.";
    };

    extraBrews = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Additional Homebrew formulae.";
    };

    extraCasks = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Additional Homebrew casks.";
    };

    extraMasApps = lib.mkOption {
      type = lib.types.attrsOf lib.types.int;
      default = { };
      description = "Additional Mac App Store apps managed by mas.";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;

      onActivation = {
        autoUpdate = cfg.autoUpdate;
        cleanup = cfg.cleanup;
      };

      taps = cfg.extraTaps;

      brews =
        lib.optionals cfg.core.enable [
          "mas"
          "tailscale"
        ]
        ++ cfg.extraBrews;

      casks =
        lib.optionals cfg.browsers.enable [
          "google-chrome"
        ]
        ++ lib.optionals cfg.communication.enable [
          "discord"
        ]
        ++ lib.optionals cfg.development.enable [
          "visual-studio-code"
          "zed"
          "ghostty"
          "orbstack"
          "antigravity"
        ]
        ++ lib.optionals cfg.ai.enable [
          "claude"
          "swama"
          "lm-studio"
        ]
        ++ lib.optionals cfg.productivity.enable [
          "notion"
        ]
        ++ lib.optionals cfg.utilities.enable [
          "karabiner-elements"
          "cleanshot"
          "tailscale-app"
          "sozercan/repo/kaset"
        ]
        ++ cfg.extraCasks;

      masApps = cfg.extraMasApps;
    };
  };
}
