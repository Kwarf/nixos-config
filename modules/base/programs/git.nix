{
  flake.modules.homeManager.base = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "me@kwarf.com";
          name = "Jimmy Bergström";
        };
        alias = {
          st = "status";
        };
      };
    };
  };
}
