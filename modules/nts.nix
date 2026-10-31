{
  services.ntpd-rs = {
    enable = true;

    # networking.timeServers can only produce plain NTP sources, not NTS
    useNetworkingTimeServers = false;

    # https://github.com/jauderho/nts-servers
    settings.source = [
      {
        mode = "nts";
        address = "sth1.nts.netnod.se";
      }
      {
        mode = "nts";
        address = "sth2.nts.netnod.se";
      }
      {
        mode = "nts";
        address = "svl1.nts.netnod.se";
      }
      {
        mode = "nts";
        address = "svl2.nts.netnod.se";
      }
    ];
  };
}
