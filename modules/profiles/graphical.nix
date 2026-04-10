{ den, ... }:
{
  den.aspects.profiles.provides.graphical = {
    includes = [
      den.aspects.software._.bitwig
      den.aspects.software._.blender
      den.aspects.software._.firefox
      den.aspects.software._.fonts
      den.aspects.software._.fractal
      den.aspects.software._.gnome
      den.aspects.software._.obs
      den.aspects.software._.steam
      den.aspects.software._.zed
      den.aspects.system._.locale._.swedishFormats
      den.aspects.system._.networking._.networkmanager._.nextdns
    ];

    provides = {
      desktop.includes = [
        (den.aspects.software._.gnome._.suspendTimeoutSeconds 3600)
      ];
      laptop.includes = [
        (den.aspects.software._.gnome._.suspendTimeoutSeconds 900)
      ];
    };
  };
}
