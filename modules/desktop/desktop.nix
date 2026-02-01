{
  flake.modules.nixos.desktop =
    { self, ... }:
    {
      imports = [
        self.modules.nixos.graphical
      ];
    };
}
