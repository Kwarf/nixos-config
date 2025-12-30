{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "phoenix";
  wifi.interface = "wlp5s0";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11"; # Did you read the comment?
}
