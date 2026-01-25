{
  flake.modules.nixos.base = {
    # I got lectured after each reboot because of impermanence throwing away the file
    security.sudo.extraConfig = ''
      Defaults lecture = never
    '';
  };
}
