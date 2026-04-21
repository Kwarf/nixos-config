{ den, ... }:
{
  den.aspects.system.provides.fingerprint = {
    includes = [
      (den.aspects.system._.impermanence._.addOptions "/persistent" {
        directories = [
          {
            directory = "/var/lib/fprint";
            mode = "0700";
          }
        ];
      })
    ];

    nixos = {
      services.fprintd.enable = true;
    };
  };
}
