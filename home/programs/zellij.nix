{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."zellij/config.kdl".source = ../../config/zellij/config.kdl;
  xdg.configFile."zellij/layouts/default.kdl".source = ../../config/zellij/default.kdl;
}
