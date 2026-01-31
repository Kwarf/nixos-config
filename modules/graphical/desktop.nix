{
  flake.modules.nixos.graphical =
    { self, pkgs, ... }:
    {
      imports = [ self.modules.nixos.greetd ];

      programs.niri.enable = true;

      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];
    };

  flake.modules.homeManager.graphical = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
