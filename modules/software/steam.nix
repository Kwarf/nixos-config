{ den, ... }:
{
  den.aspects.software.provides.steam = {
    includes = [
      (den.aspects.services._.flatpak._.addPackage "com.valvesoftware.Steam")
    ];
  };
}
