{ den, ... }:
{
  den.aspects.software.provides.fractal = {
    includes = [
      (den.aspects.services._.flatpak._.addPackage "org.gnome.Fractal")
    ];
  };
}
