{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bitwig-studio
    pkgsRocm.blender
  ];
}
