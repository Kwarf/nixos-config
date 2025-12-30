{
  config,
  lib,
  options,
  ...
}: {
  options.wifi.interface = lib.mkOption {
    type = lib.types.str;
    default = null;
    example = "wlp5s0";
    description = "WiFi interface to configure";
  };

  config = lib.mkIf (config.wifi.interface != null) {
    networking.supplicant.${config.wifi.interface} = {
      configFile.path = config.sops.secrets.wifi.path;
    };
  };

  #config.networking.wireless = {
  #  enable = true;
  #  extraConfigFiles = [
  #    config.sops.secrets.wifi.path
  #  ];
  #};
}
