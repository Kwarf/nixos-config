{
  flake.modules.nixos.graphical =
    { self, pkgs, ... }:
    {
      imports = [ self.modules.nixos.greetd ];

      programs.niri.enable = true;

      environment.systemPackages = with pkgs; [
        ironbar
        xwayland-satellite
      ];
    };

  flake.modules.homeManager.graphical =
    { config, ... }:
    let
      graphical = "${config.home.homeDirectory}/nixos-config/modules/graphical";
    in
    {
      xdg.configFile."niri/config.kdl" = {
        force = true;
        source = config.lib.file.mkOutOfStoreSymlink "${graphical}/niri/config.kdl";
      };

      programs.yazi.enable = true;
    };
}
