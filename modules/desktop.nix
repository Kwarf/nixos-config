{ lib, pkgs, ... }:
{
  boot.plymouth.enable = true;

  # Hide the text output around the splash
  boot.consoleLogLevel = 3;
  boot.kernelParams = [
    "quiet"
    "udev.log_level=3"
  ];

  # Load the GPU driver early, so the splash doesn't flicker or change resolution
  hardware.amdgpu.initrd.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-initial-setup.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome-contacts
    gnome-tour
    gnome-user-docs
  ];

  environment.systemPackages = with pkgs; [
    fractal
    gnome-tweaks
    gnomeExtensions.tiling-shell
  ];

  # These are defaults, values set by the user take priority.
  # Run "dconf watch /" then make the desired change to see how to define it.
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        # GNOME saves these lists whole when they're changed in the UI, which hides later edits made
        # here. To go back to the values below, run e.g.: dconf reset /org/gnome/shell/favorite-apps
        "org/gnome/shell" = {
          enabled-extensions = [ pkgs.gnomeExtensions.tiling-shell.extensionUuid ];
          favorite-apps = [
            "org.gnome.Nautilus.desktop"
            "firefox.desktop"
            "org.gnome.Console.desktop"
          ];
        };
        "org/gnome/desktop/interface" = {
          font-antialiasing = "rgba";
          show-battery-percentage = true;
        };
        "org/gnome/desktop/wm/keybindings" = {
          switch-applications = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          switch-applications-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          switch-windows = [ "<Alt>Tab" ];
          switch-windows-backward = [ "<Shift><Alt>Tab" ];
          toggle-fullscreen = [ "<Super>f" ];
        };
        "org/gnome/desktop/wm/preferences" = {
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
    }
  ];

  programs.firefox.enable = true;
}
