{
  den.aspects.system.provides.zswap = {
    nixos = {
      # https://www.kernel.org/doc/html/latest/admin-guide/mm/zswap.html
      boot.kernelParams = [
        "zswap.enabled=1"
        "zswap.shrinker_enabled=1"
        "zswap.max_pool_percent=20"
        "zswap.compressor=zstd"
        "zswap.accept_threshold_percent=90"
      ];
    };
  };
}
