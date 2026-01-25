{
  flake.modules.nixos.laptop =
    { self, ... }:
    {
      imports = [
        self.modules.nixos.graphical
      ];
    };
}
