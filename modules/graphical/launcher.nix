{
  flake.modules.homeManager.graphical = {
    programs.vicinae = {
      enable = true;
      systemd.enable = true;
    };
  };
}
