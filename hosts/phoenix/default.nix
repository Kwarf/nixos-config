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

  networking.hostName = "phoenix";

  boot.zswap.enable = true;

  # RTX 2080 Super (Turing), the oldest generation the open kernel modules support
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  # The newer of the production and new feature branches, stable only follows production
  hardware.nvidia.branch = "latest";

  # Keeps VRAM contents across suspend, without it GNOME can come back with garbled windows
  hardware.nvidia.powerManagement.enable = true;

  # The VRAM is saved to /tmp on suspend, which would otherwise be on the 2G root and too small for
  # the card's 8G. This gives /tmp its own tmpfs, which defaults to half the RAM.
  boot.tmp.useTmpfs = true;

  # Load the GPU driver early, so the splash doesn't flicker or change resolution
  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_drm"
  ];

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
