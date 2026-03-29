{ den, ... }:
{
  den.aspects.system.provides.bootloader = {
    boot.loader.efi.canTouchEfiVariables = true;
    provides = {
      systemd-boot = {
        includes = [ den.aspects.system._.bootloader ];
        nixos.boot.loader.systemd-boot = {
          enable = true;
          consoleMode = "max";
        };
      };
    };
  };
}
