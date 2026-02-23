{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    settings = {
      theme = "nord";
      font-family = "Maple Mono NF";
      font-size = 14;
      mouse-hide-while-typing = true;
      selection-foreground = "cell-foreground";
      selection-background = "#44475a";
      scrollback-limit = 10000;
    };
    enableZshIntegration = true;
  };
}
