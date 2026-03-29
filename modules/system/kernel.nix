{
  den.aspects.system.provides.kernel = {
    provides = {
      latest = {
        nixos =
          { pkgs, ... }:
          {
            boot.kernelPackages = pkgs.linuxPackages_latest;
          };
      };
    };
  };
}
