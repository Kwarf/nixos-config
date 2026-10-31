{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [ inputs.claude-code.overlays.default ];

  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    claude-code
    vscode

    # Needed by Claude Code's built-in sandbox
    bubblewrap
    socat
  ];
}
