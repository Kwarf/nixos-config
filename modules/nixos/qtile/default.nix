{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  qtile = inputs.qtile.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  config = {
    # Launch Qtile through UWSM to ensure proper session management
    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        qtile = {
          prettyName = "Qtile";
          comment = "Qtile managed by UWSM";
          binPath = lib.getExe qtile;
          extraArgs = [
            "start"
            "-b"
            "wayland"
          ];
        };
      };
    };

    services = {
      xserver.windowManager.qtile = {
        enable = true;
        package = qtile;
      };

      # Use greetd as a display manager when running qtile
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${lib.getExe pkgs.tuigreet} -s ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions -t";
          };
        };
      };
    };

    environment.systemPackages = with pkgs; [
      tuigreet
    ];
  };
}
