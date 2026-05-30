{ inputs, ... }:
{
  flake-file.inputs.plasma-manager = {
    url = "github:nix-community/plasma-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  den.aspects.software.provides.plasma = {
    nixos = {
      services.displayManager.plasma-login-manager.enable = true;
      services.desktopManager.plasma6.enable = true;
    };

    homeManager = {
      imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

      # https://nix-community.github.io/plasma-manager/options.xhtml
      programs.plasma = {
        enable = true;
        overrideConfig = true;

        configFile = {
          kwinrc.Xwayland.Scale = 1.0;
        };
      };
    };

    provides = {
      suspendTimeoutSeconds = seconds: {
        homeManager.programs.plasma = {
          powerdevil = {
            AC.autoSuspend = {
              action = "sleep";
              idleTimeout = seconds;
            };
            battery.autoSuspend = {
              action = "sleep";
              idleTimeout = seconds;
            };
          };
        };
      };
    };
  };
}
