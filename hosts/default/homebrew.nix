{ lib, ... }:

{
  unipota.homebrew = {
    enable = lib.mkDefault true;

    core.enable = lib.mkDefault true;
    browsers.enable = lib.mkDefault true;
    communication.enable = lib.mkDefault true;
    development.enable = lib.mkDefault true;
    ai.enable = lib.mkDefault true;
    productivity.enable = lib.mkDefault true;
    utilities.enable = lib.mkDefault true;
  };
}
