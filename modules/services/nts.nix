{ den, ... }:
{
  den.aspects.services.provides.nts = {
    nixos = {
      services.ntpd-rs = {
        enable = true;
        settings.observability.log-level = "warn";
      };
    };

    provides = {
      addServers = servers: {
        nixos.networking.timeServers = servers;
      };
      # https://github.com/jauderho/nts-servers
      servers = {
        provides = {
          stockholm.includes = [
            (den.aspects.services._.nts._.addServers [
              "sth1.nts.netnod.se"
              "sth2.nts.netnod.se"
            ])
          ];
          sundsvall.includes = [
            (den.aspects.services._.nts._.addServers [
              "svl1.nts.netnod.se"
              "svl2.nts.netnod.se"
            ])
          ];
        };
      };
    };
  };
}
