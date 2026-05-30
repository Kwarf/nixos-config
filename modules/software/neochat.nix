{ den, ... }:
{
  den.aspects.software.provides.neochat = {
    includes = [
      (den.aspects.services._.flatpak._.addPackage "org.kde.neochat")
    ];
  };
}
