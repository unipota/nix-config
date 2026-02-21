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
      ];
      home.sessionVariables = {
        NH_FLAKE = "${config.home.homeDirectory}/.config/nix-darwin";
      };

      home.sessionPath = [
        "${config.home.homeDirectory}/.antigravity/antigravity/bin"
      ];

      home.packages = with pkgs; [
        # --- Modern environment essentials ---
        neovim
        fzf
        ripgrep
        fd
        jq
        gemini-cli
        fastfetch
        zsh-completions
        zsh-autosuggestions
        zsh-syntax-highlighting

        # --- Development Environments ---
        nodejs
        pnpm
        rustc
        cargo
        rust-analyzer
        go
      ];

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        initContent = builtins.readFile ../../config/zshrc.sh;

        oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "robbyrussell";
        };
      };

      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.atuin = {
        enable = true;
        enableZshIntegration = true;
        flags = [ "--disable-up-arrow" ];
      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.carapace = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "unipota";
            email = "unipota@outlook.jp";
          };
        };
      };

      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          navigate = true;
          line-numbers = true;
          syntax-theme = "Dracula";
        };
      };

      programs.starship.enable = true;
      home.file.".config/starship.toml".source = ../../config/starship.toml;

      programs.ghostty = {
        enable = true;
        package = pkgs.ghostty-bin;
        settings = {
          font-family = "Maple Mono NF";
          font-size = 14;
          mouse-hide-while-typing = true;
          selection-foreground = "cell-foreground";
          selection-background = "#44475a";
          scrollback-limit = 10000;
        };
        enableZshIntegration = true;
      };

      catppuccin.ghostty = {
        enable = true;
        flavor = "macchiato";
      };

      home.stateVersion = "23.11";

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableZshIntegration = true;
      };

      programs.eza = {
        enable = true;
        git = true;
        icons = "auto";
        enableZshIntegration = true;
      };

      programs.bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          batman
          prettybat
        ];
      };

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };
    };
}
