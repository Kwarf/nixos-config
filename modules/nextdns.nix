{ config, ... }:
let
  hostname = "${config.networking.hostName}-${config.sops.placeholder.nextdns-id}.dns.nextdns.io";
in
{
  sops.secrets.nextdns-id = { };

  # Rendered at activation, networking.nameservers would put the ID in the Nix store. DNSOverTLS
  # stays in here too: without these servers it would break DNS, as the router doesn't support it.
  sops.templates."nextdns.conf" = {
    path = "/etc/systemd/resolved.conf.d/nextdns.conf";
    mode = "0444";
    restartUnits = [ "systemd-resolved.service" ];
    content = ''
      [Resolve]
      DNS=45.90.28.0#${hostname} 2a07:a8c0::#${hostname} 45.90.30.0#${hostname} 2a07:a8c1::#${hostname}
      DNSOverTLS=true
    '';
  };

  services.resolved.enable = true;

  networking.networkmanager.dns = "systemd-resolved";
}
