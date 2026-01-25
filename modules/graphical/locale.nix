{
  # Graphical environments include sv_SE.UTF-8 as well, for time and addresses and such
  flake.modules.nixos.graphical =
    { pkgs, ... }:
    {
      i18n.extraLocales = [ "sv_SE.UTF-8/UTF-8" ];
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "sv_SE.UTF-8";
        LC_IDENTIFICATION = "sv_SE.UTF-8";
        LC_MEASUREMENT = "sv_SE.UTF-8";
        LC_MONETARY = "sv_SE.UTF-8";
        LC_NAME = "sv_SE.UTF-8";
        LC_NUMERIC = "sv_SE.UTF-8";
        LC_PAPER = "sv_SE.UTF-8";
        LC_TELEPHONE = "sv_SE.UTF-8";
        LC_TIME = "sv_SE.UTF-8";
      };

      services.xserver.xkb.layout = "se";
    };
}
