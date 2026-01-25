{
  flake.modules.nixos.base =
    { lib, ... }:
    {
      nix = {
        settings = {
          experimental-features = lib.mkDefault [
            "nix-command"
            "flakes"
          ];
        };
        channel.enable = false;
      };
    };
}
