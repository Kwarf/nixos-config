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
      cmd-lock = "${pkgs.swaylock}/bin/swaylock -fF";
      cmd-display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
      graphical = "${config.home.homeDirectory}/nixos-config/modules/graphical";
    in
    {
      programs.swaylock.enable = true;
      catppuccin.swaylock.enable = true;

      services.swayidle = {
        enable = true;
        systemdTarget = "niri.service";
        events = {
          after-resume = cmd-display "on";
          before-sleep = cmd-lock;
          lock = cmd-lock;
        };
        timeouts = [
          {
            timeout = 300;
            command = cmd-lock + "; " + (cmd-display "off");
          }
        ];
      };

      home.packages = with pkgs; [
        wbg
      ];

      xdg.configFile."niri/config.kdl" = {
        force = true;
        source = config.lib.file.mkOutOfStoreSymlink "${graphical}/niri/config.kdl";
      };
    };
}
