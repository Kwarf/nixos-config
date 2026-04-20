{ den, ... }:
{
  den.aspects.services.provides.tailscale = {
    includes = [
      (den.aspects.system._.impermanence._.addOptions "/persistent" {
        files = [
          "/var/lib/tailscale/tailscaled.state"
        ];
      })
    ];

    nixos = {
      services.tailscale.enable = true;
    };
  };
}
