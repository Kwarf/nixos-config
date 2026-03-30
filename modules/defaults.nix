{ lib, den, ... }:
{
  den.default.nixos.system.stateVersion = "25.11";
  den.default.homeManager.home.stateVersion = "25.11";

  den.default.nixos.home-manager.useGlobalPkgs = true;

  den.default.includes = [
    den._.hostname
    den.aspects.system._.nix
    den.aspects.system._.locale
  ];

  # enable hm by default
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  # host<->user provides
  den.ctx.user.includes = [ den._.mutual-provider ];
}
