{
  config,
  lib,
  ...
}: {
  config.sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/kwarf/.config/sops/age/keys.txt";
    secrets = {
      hashedLocalUserPassword = {
        neededForUsers = true;
      };
      wifi = {
        sopsFile = ../../../secrets/wifi.conf;
        format = "binary";
        restartUnits = lib.mkIf (config.wifi.interface != null) [
          "supplicant-${config.wifi.interface}.service"
        ];
      };
    };
  };
}
