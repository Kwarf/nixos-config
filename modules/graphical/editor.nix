{
  flake.modules.homeManager.graphical =
    { pkgs, ... }:
    {
      programs.zed-editor = {
        enable = true;
        extensions = [
          "catppuccin"
          "nix"
        ];
        extraPackages = with pkgs; [
          nixd
          nixfmt
        ];
      };
    };
}
