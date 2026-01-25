{
  flake.modules.nixos.graphical =
    { config, ... }:
    let
      secrets = config.my.secrets;
    in
    {
      networking.networkmanager = {
        enable = true;
        ensureProfiles.profiles = secrets.wifiProfiles;
      };
    };
}
