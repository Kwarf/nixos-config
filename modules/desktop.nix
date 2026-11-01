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

  # Holds the avatar picked in Settings, which GDM and the lock screen show
  preservation.preserveAt."/persistent".directories = [ "/var/lib/AccountsService" ];

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    gnome-contacts
    gnome-system-monitor
    gnome-tour
    gnome-user-docs
    showtime
  ];

  environment.systemPackages = with pkgs; [
    cine
    fractal
    gnome-tweaks
    gnomeExtensions.tiling-shell
    resources
    tonearm
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

  # Uses GNOME Shell's own prompt and supports SSH_ASKPASS_PROMPT, unlike the Seahorse default.
  # nixpkgs' openssh-askpass only builds the GTK 3 variant, so this switches it to the GCR one.
  programs.ssh.askPassword =
    let
      askpass = pkgs.openssh-askpass.overrideAttrs {
        buildInputs = [ pkgs.gcr_4 ];
        makeFlags = "gnome-ssh-askpass4";
        installPhase = ''
          runHook preInstall
          install -Dm755 gnome-ssh-askpass4 $out/libexec/gnome-ssh-askpass4
          runHook postInstall
        '';
      };
    in
    "${askpass}/libexec/gnome-ssh-askpass4";

  programs.firefox.enable = true;
}
