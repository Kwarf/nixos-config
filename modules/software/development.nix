{
  den.aspects.software.provides.development = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ direnv ];
      };
  };
}
