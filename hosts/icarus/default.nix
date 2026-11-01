{ lib, ... }:
{
  imports = [
    ./disko.nix
    ./hardware.nix
    ../../modules/base.nix
    ../../modules/claude.nix
    ../../modules/creative.nix
    ../../modules/desktop.nix
    ../../modules/development.nix
    ../../modules/flatpak.nix
    ../../modules/fonts.nix
    ../../modules/locale.nix
    ../../modules/nextdns.nix
    ../../modules/nts.nix
    ../../modules/preservation.nix
    ../../modules/secrets.nix
    ../../modules/ssh.nix
    ../../modules/tailscale.nix
    ../../modules/tpm.nix
    ../../modules/user.nix
  ];

  networking.hostName = "icarus";

  # Login pages are unreachable with the DNS over TLS from nextdns.nix, this uses the network's DNS
  programs.captive-browser = {
    enable = true;
    interface = "wlp2s0";
  };

  boot.zswap.enable = true;

  services.fprintd.enable = true;
  preservation.preserveAt."/persistent".directories = [
    {
      directory = "/var/lib/fprint";
      mode = "0700";
    }
  ];

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-timeout =
        lib.gvariant.mkInt32 900;
    }
  ];

  # The NixOS version first installed on this machine. Not an upgrade knob, leave it alone.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "26.05";
}
