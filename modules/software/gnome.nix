{
  den.aspects.software.provides.gnome = {
    nixos =
      { pkgs, ... }:
      {
        services.displayManager.gdm.enable = true;
        services.desktopManager.gnome.enable = true;

        environment.gnome.excludePackages = with pkgs; [
          epiphany
          gnome-contacts
          gnome-initial-setup
          gnome-tour
          gnome-user-docs
        ];
      };

    homeManager = {
      # Run "dconf watch /" then make the desired change to see how to define it
      dconf.settings = {
        "org/gnome/shell" = {
          favorite-apps = [
            "org.gnome.Nautilus.desktop"
            "firefox.desktop"
            "org.gnome.Console.desktop"
          ];
        };
        "org/gnome/settings-daemon/plugins/housekeeping" = {
          donation-reminder-enabled = false;
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          natural-scroll = false;
        };
        "org/gnome/desktop/peripherals/pointingstick" = {
          speed = -0.6;
        };
      };
    };
  };
}
