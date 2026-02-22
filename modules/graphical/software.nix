# General non-nix-configured software packages that don't belong in any specific "area"
{
  flake.modules.nixos.graphical = {
    nixpkgs = {
      config = {
        allowUnfree = true;
        rocmSupport = true; # For HW acceleration in Blender
      };
    };

    programs.steam.enable = true;
  };

  flake.modules.homeManager.graphical =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        blender
        ffmpeg
        mpv
      ];

      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          obs-vaapi
        ];
      };
    };
}
