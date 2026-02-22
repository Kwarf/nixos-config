{
  flake.modules.homeManager.graphical = {
    programs.vicinae = {
      enable = true;
      systemd.enable = true;
      settings = {
        launcher_window = {
          opacity = 1.0;
          client_side_decorations = {
            rounding = 0;
            border_width = 4;
          };
        };
        favorites = [ ];
        providers = {
          clipboard.preferences.monitoring = false;
        };
      };
    };
    catppuccin.vicinae.enable = true;
  };
}
