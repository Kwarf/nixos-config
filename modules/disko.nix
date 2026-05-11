{ inputs, ... }:
{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.schema.host.includes = [
    { nixos.imports = [ inputs.disko.nixosModules.disko ]; }
  ];
}
