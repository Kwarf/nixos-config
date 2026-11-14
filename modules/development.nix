{ pkgs, ... }:
{
  programs.direnv.enable = true;

  # Rootless by default, images live under ~/.local/share/containers on the persistent /home
  virtualisation.podman.enable = true;

  environment.systemPackages = [
    pkgs.podman-compose
    pkgs.vscode
  ];
}
