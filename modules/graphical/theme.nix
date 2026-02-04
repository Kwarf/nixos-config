{
  flake-file.inputs.catppuccin = {
    url = "github:catppuccin/nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.graphical =
    { inputs, ... }:
    {
      imports = [
        inputs.catppuccin.nixosModules.catppuccin
      ];

      home-manager.users.kwarf.imports = [
        inputs.catppuccin.homeModules.catppuccin
      ];
    };

  flake.modules.homeManager.graphical = {
    catppuccin.flavor = "frappe";
  };
}
