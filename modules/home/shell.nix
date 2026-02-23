{ config, pkgs, ... }:

{
  home.sessionVariables = {
    NH_FLAKE = "${config.home.homeDirectory}/Workspace/nix-darwin";
    CARAPACE_BRIDGES = "zsh,fish,bash,inshellisense";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.antigravity/antigravity/bin"
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -l --icons --git";
      la = "eza -la --icons --git";
      ".." = "cd ..";
      "..." = "cd ../..";
      cd = "z";
      cat = "bat";
      find = "fd";
      grep = "rg";
      g = "git";
      ga = "git add";
      gc = "git commit";
      gs = "git status";
      gp = "git push";
      gl = "git pull";
      darwin-update = "nix run ~/Workspace/nix-darwin#update";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

    initContent = ''
      # --- FZF ---
      pf() {
        fzf --preview "bat --style=numbers --color=always --line-range :500 {}"
      }

      # --- Carapace ---
      zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
      source <(carapace _carapace)
    '';
  };

  programs.starship.enable = true;
  home.file.".config/starship.toml".source = ../../config/starship.toml;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
  };
}
