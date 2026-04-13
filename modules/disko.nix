{ inputs, ... }:
{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.ctx.host.includes = [
    { nixos.imports = [ inputs.disko.nixosModules.disko ]; }
  ];
}
