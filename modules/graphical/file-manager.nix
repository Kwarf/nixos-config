{
  flake.modules.nixos.graphical =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        xdg-desktop-portal-termfilechooser
      ];

      xdg.portal.config.niri."org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
    };

  flake.modules.homeManager.graphical =
    { pkgs, ... }:
    {
      programs.yazi.enable = true;

      xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
        default_dir=$HOME
        env=TERMCMD=footclient --app-id=termfilechooser
        open_mode=suggested
        save_mode=suggested
      '';
    };
}
