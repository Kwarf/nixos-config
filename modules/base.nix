{
  config,
  inputs,
  pkgs,
  ...
}:
let
  revision = inputs.self.shortRev or inputs.self.dirtyShortRev or "unknown";
in
{
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.channel.enable = false;

  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    flake = "/home/kwarf/Projects/nixos-config";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 7d --keep 10";
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Shows which commit each generation was built from
  system.nixos.label = "${config.system.nixos.version}-${revision}";

  networking.networkmanager.enable = true;

  # sudo records that the lecture was shown on the ephemeral root, so it would repeat every boot
  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  environment.systemPackages = [ pkgs.neovim ];
}
