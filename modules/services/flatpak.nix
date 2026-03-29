{ den, inputs, ... }:
{
  flake-file.inputs.nix-flatpak = {
    url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  den.aspects.services.provides.flatpak = {
    nixos = {
      services.flatpak.enable = true;
    };

    homeManager = {
      imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];
    };

    provides = {
      addPackage = package: {
        includes = [ den.aspects.services._.flatpak ];
        homeManager.services.flatpak.packages = [
          package
        ];
      };
    };
  };
}
