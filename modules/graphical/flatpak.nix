{
  flake-file.inputs.nix-flatpak = {
    url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  flake.modules.nixos.graphical =
    { inputs, ... }:
    {
      services.flatpak.enable = true;

      home-manager.users.kwarf.imports = [
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
      ];
    };

  flake.modules.homeManager.graphical = {
    services.flatpak.packages = [
      "im.riot.Riot"
    ];
  };
}
