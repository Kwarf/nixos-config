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

        environment.systemPackages = with pkgs; [
          gnome-tweaks
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
        "org/gnome/desktop/interface" = {
          font-antialiasing = "rgba";
        };
        "org/gnome/desktop/wm/preferences" = {
          mouse-button-modifier = "<Alt>";
          resize-with-right-button = true;
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
