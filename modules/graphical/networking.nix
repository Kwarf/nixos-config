{
  flake.modules.nixos.graphical =
    { config, ... }:
    let
      secrets = config.my.secrets;
      dnsUrl = "${config.networking.hostName}-${secrets.nextdns.id}.dns.nextdns.io";
    in
    {
      services.resolved = {
        enable = true;
        settings.Resolve.DNSOverTLS = true;
      };

      networking = {
        nameservers = [
          "45.90.28.0#${dnsUrl}"
          "2a07:a8c0::#${dnsUrl}"
          "45.90.30.0#${dnsUrl}"
          "2a07:a8c1::#${dnsUrl}"
        ];

        networkmanager = {
          enable = true;
          dns = "systemd-resolved";
          ensureProfiles.profiles = secrets.wifiProfiles;
        };
      };
    };

  flake.modules.nixos.desktop = {
    networking.networkmanager.wifi.powersave = false;
  };
}
