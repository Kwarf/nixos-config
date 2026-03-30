{
  den.aspects.software.provides.blender = {
    nixos.nixpkgs.config.rocmSupport = true;
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.blender ];
      };
  };
}
