{ pkgs, ... }:
{
  programs.direnv.enable = true;

  environment.systemPackages = [ pkgs.vscode ];
}
