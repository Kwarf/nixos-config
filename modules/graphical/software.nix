# General non-nix-configured software packages that don't belong in any specific "area"
{
  flake.modules.nixos.graphical = {
    nixpkgs = {
      config = {
        rocmSupport = true; # For HW acceleration in Blender
      };
    };
  };

  flake.modules.homeManager.graphical =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        blender
        ffmpeg
        mpv
      ];
    };
}
