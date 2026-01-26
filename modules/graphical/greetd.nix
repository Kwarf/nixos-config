{
  flake.modules.nixos.greetd =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${lib.getExe pkgs.tuigreet} -s ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions -t";
          };
        };
      };

      environment.systemPackages = with pkgs; [
        tuigreet
      ];
    };
}
