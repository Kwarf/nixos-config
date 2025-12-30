{config, ...}: {
  config.services.openssh.enable = true;
  config.networking.firewall.allowedTCPPorts = [22];
}
