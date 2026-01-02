{
  config,
  lib,
  options,
  pkgs,
  ...
}: {
  options.laptop.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = "Enable laptop specific settings and software";
  };

  config = lib.mkIf (config.laptop.enable) {
    environment.systemPackages = with pkgs; [
      brightnessctl
    ];
  };
}
