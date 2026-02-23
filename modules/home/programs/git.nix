{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "unipota";
        email = "unipota@outlook.jp";
      };
    };
    ignores = [
      ".DS_Store"
      "*.swp"
      ".direnv/"
    ];
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
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

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  # New Developer Tool
  programs.lazygit = {
    enable = true;
  };
}
