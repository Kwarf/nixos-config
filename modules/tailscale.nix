{
  services.tailscale.enable = true;

  # Node identity, without this the machine has to re-authenticate after every boot
  preservation.preserveAt."/persistent".directories = [ "/var/lib/tailscale" ];
}
