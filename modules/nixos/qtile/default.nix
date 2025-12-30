{
  config,
  inputs,
  pkgs,
  ...
}: let
  launch-qtile = pkgs.writeShellScriptBin "launch-qtile" ''
    #!${pkgs.runtimeShell}
    export XDG_SESSION_TYPE=wayland
    dbus-run-session -- ${inputs.qtile.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/qtile start -b wayland
  '';
in {
  config = {
    environment.systemPackages = with pkgs; [
      tuigreet
    ];

    services.xserver.windowManager.qtile = {
      enable = true;
      package = inputs.qtile.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    # Use greetd as a display manager when running qtile
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet -c '${launch-qtile}/bin/launch-qtile'";
        };
      };
    };
  };
}
