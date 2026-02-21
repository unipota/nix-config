{ pkgs, ... }:

let
  kanataConfig = pkgs.writeText "kanata.kbd" (builtins.readFile ../../config/kanata.kbd);
in
{
  launchd.daemons.kanata = {
    serviceConfig = {
      ProgramArguments = [
        "${pkgs.kanata-with-cmd}/bin/kanata"
        "-c"
        "${kanataConfig}"
      ];
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "/var/log/kanata.out.log";
      StandardErrorPath = "/var/log/kanata.err.log";
      EnvironmentVariables = {
        "KanataConfigPath" = "${kanataConfig}";
      };
    };
  };
}
