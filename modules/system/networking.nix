{ config, den, ... }:
let
  dnsUrl = hostName: "${hostName}-${config.my.secrets.nextdns.id}.dns.nextdns.io";
  mkWifiProfile = connection: {
    name = connection.ssid;
    value = {
      connection = {
        id = connection.ssid;
        type = "wifi";
      };
      wifi = {
        mode = "infrastructure";
        ssid = connection.ssid;
      };
      wifi-security = {
        key-mgmt = connection.security;
        psk = connection.psk;
      };
      ipv4 = {
        method = "auto";
      };
      ipv6 = {
        addr-gen-mode = "default";
        method = "auto";
      };
    };
  };
in
{
  den.aspects.system.provides.networking = {
    provides = {
      captive-browser = interface: {
        nixos = {
          programs.captive-browser = {
            enable = true;
            interface = interface;
          };
        };
      };
      networkmanager = {
        nixos = {
          networking.networkmanager.enable = true;
        };
        provides = {
          nextdns =
            { host, ... }:
            {
              nixos = {
                services.resolved = {
                  enable = true;
                  settings.Resolve.DNSOverTLS = true;
                };

                networking = {
                  networkmanager.dns = "systemd-resolved";
                  nameservers = [
                    "45.90.28.0#${dnsUrl host.hostName}"
                    "2a07:a8c0::#${dnsUrl host.hostName}"
                    "45.90.30.0#${dnsUrl host.hostName}"
                    "2a07:a8c1::#${dnsUrl host.hostName}"
                  ];
                };
              };
            };
        };
      };
      wifi = {
        includes = [
          den.aspects.system._.networking._.networkmanager
        ];

        nixos.networking.networkmanager.ensureProfiles.profiles = builtins.listToAttrs (
          map mkWifiProfile [ config.my.secrets.wifiHomeNetwork ]
        );

        provides.allNetworks.nixos.networking.networkmanager.ensureProfiles.profiles =
          builtins.listToAttrs (map mkWifiProfile config.my.secrets.wifiNetworks);
      };
    };
  };
}
