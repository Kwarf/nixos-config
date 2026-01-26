{
  flake.modules.nixos.graphical =
    { self, ... }:
    {
      imports = [ self.modules.nixos.greetd ];

      programs.niri.enable = true;
    };
}
