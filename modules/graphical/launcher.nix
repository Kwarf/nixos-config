{
  flake.modules.homeManager.graphical = {
    programs.vicinae = {
      enable = true;
      systemd.enable = true;
      settings = {
        providers = {
          clipboard.preferences.monitoring = false;
        };
      };
    };
  };
}
