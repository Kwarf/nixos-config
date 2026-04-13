{ den, inputs, ... }:
{
  flake-file.inputs.nix-flatpak = {
    url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  flake-file.inputs.nixpkgs-master = {
    url = "github:NixOS/nixpkgs/master";
  };

  den.aspects.services.provides.flatpak = {
    nixos = {
      # Until https://nixpk.gs/pr-tracker.html?pr=508601 lands, due to https://github.com/flathub/com.valvesoftware.Steam/issues/1535
      nixpkgs.config.packageOverrides = pkgs: {
        flatpak = inputs.nixpkgs-master.legacyPackages.${pkgs.stdenv.hostPlatform.system}.flatpak;
      };

      services.flatpak.enable = true;
    };

    homeManager = {
      imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];
      services.flatpak = {
        uninstallUnmanaged = true;
        uninstallUnused = true;
        update.onActivation = true;
      };
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
