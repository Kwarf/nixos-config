{ inputs, den, ... }:
{
  flake-file.inputs.impermanence = {
    url = "github:nix-community/impermanence";
    inputs.nixpkgs.follows = "";
    inputs.home-manager.follows = "";
  };

  den.aspects.system.provides.impermanence = {
    nixos = {
      imports = [ inputs.impermanence.nixosModules.impermanence ];

      # Prevent getting lectured after each reboot because of impermanence throwing away the file
      security.sudo.extraConfig = ''
        Defaults lecture = never
      '';

      # On impermanence hosts the users should be immutable
      users.mutableUsers = false;
    };

    provides = {
      addPersistance = mountpoint: {
        includes = [ den.aspects.system._.impermanence ];
        nixos = {
          environment.persistence.${mountpoint}.hideMounts = true;
          fileSystems.${mountpoint}.neededForBoot = true;
        };
      };
      addOptions = mountpoint: opts: {
        nixos.environment.persistence.${mountpoint} = opts;
      };
    };
  };
}
