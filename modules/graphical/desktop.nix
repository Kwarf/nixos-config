{
  flake.modules.nixos.graphical =
    { self, ... }:
    {
      imports = [ self.modules.nixos.greetd ];

      programs.niri.enable = true;
    };

  flake.modules.homeManager.graphical = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
