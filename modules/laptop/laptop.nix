{
  flake.modules.nixos.laptop =
    { self, ... }:
    {
      imports = [
        self.modules.nixos.graphical
      ];

      services.tlp = {
        enable = true;
        settings = {
          START_CHARGE_THRESH_BAT0 = 50;
          STOP_CHARGE_THRESH_BAT0 = 70;
        };
      };
    };
}
