{
  flake-file.inputs.nixpkgs = {
    url = "github:nixos/nixpkgs/nixos-unstable";
  };

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
