{
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.base =
    { self, inputs, ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        users.kwarf.imports = [
          (
            { osConfig, ... }:
            {
              home.stateVersion = osConfig.system.stateVersion;
            }
          )
          self.modules.homeManager.base
        ];
      };
    };

  flake.modules.nixos.graphical =
    { self, inputs, ... }:
    {
      home-manager.users.kwarf.imports = [
        self.modules.homeManager.graphical
      ];
    };

  flake.modules.nixos.laptop =
    { self, inputs, ... }:
    {
      home-manager.users.kwarf.imports = [
        self.modules.homeManager.laptop
      ];
    };
}
