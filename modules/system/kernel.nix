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
      "6_18" = {
        nixos =
          { pkgs, ... }:
          {
            boot.kernelPackages = pkgs.linuxPackages_6_18;
          };
      };
    };
  };
}
