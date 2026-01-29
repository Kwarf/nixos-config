{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      programs.fish.enable = true;
      users.users.kwarf.shell = pkgs.fish;
    };
}
