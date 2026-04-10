{ den, ... }:
{
  den.aspects.software.provides.bitwig = {
    includes = [
      (den.provides.unfree [ "bitwig-studio6" ])
    ];

    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.bitwig-studio ];
      };
  };
}
