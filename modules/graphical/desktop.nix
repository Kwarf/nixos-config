{
  flake.modules.nixos.graphical =
    { self, pkgs, ... }:
    {
      imports = [ self.modules.nixos.greetd ];

      programs.niri.enable = true;

      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];

      security.pam.services.swaylock = { };
    };

  flake.modules.homeManager.graphical =
    { config, pkgs, ... }:
    let
      graphical = "${config.home.homeDirectory}/nixos-config/modules/graphical";
    in
    {
      programs.swaylock.enable = true;
      catppuccin.swaylock.enable = true;

      home.packages = with pkgs; [
        wbg
      ];

      xdg.configFile."niri/config.kdl" = {
        force = true;
        source = config.lib.file.mkOutOfStoreSymlink "${graphical}/niri/config.kdl";
      };
    };
}
