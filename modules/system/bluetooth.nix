{ den, ... }:
{
  den.aspects.system.provides.bluetooth = {
    includes = [
      (den.aspects.system._.impermanence._.addOptions "/persistent" {
        directories = [
          {
            directory = "/var/lib/bluetooth";
            mode = "0700";
          }
        ];
      })
    ];

    nixos = {
      hardware.bluetooth.enable = true;
    };
  };
}
