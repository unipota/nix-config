{ pkgs, ... }:

{
  programs.zellij = {
    enable = false;
    enableZshIntegration = false;
  };

  xdg.configFile."zellij/config.kdl".source = ../../config/zellij/config.kdl;
  xdg.configFile."zellij/layouts/default.kdl".source = ../../config/zellij/default.kdl;
}
