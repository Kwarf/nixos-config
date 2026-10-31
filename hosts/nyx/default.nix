{ lib, ... }:
{
  imports = [
    ./disko.nix
    ./hardware.nix
    ../../modules/base.nix
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

  networking.hostName = "nyx";

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-timeout =
        lib.gvariant.mkInt32 3600;
    }
  ];

  # The NixOS version first installed on this machine. Not an upgrade knob, leave it alone.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "26.05";
}
