{
  flake.modules.homeManager.laptop = {
    services = {
      shikane = {
        enable = true;
        settings = {
          profile = [
            {
              name = "builtin-only";
              output = [
                {
                  match = "eDP-1";
                  enable = true;
                }
              ];
            }
            {
              name = "docked";
              output = [
                {
                  match = "eDP-1";
                  enable = false;
                }
                {
                  match = "m=LF32TU87";
                  enable = true;
                }
              ];
            }
          ];
        };
      };
    };
  };
}
