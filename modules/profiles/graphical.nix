{ den, ... }:
{
  den.aspects.profiles.provides.graphical = {
    includes = [
      den.aspects.software._.firefox
      den.aspects.software._.gnome
      den.aspects.software._.zed
      den.aspects.system._.locale._.swedishFormats
      den.aspects.system._.networking._.networkmanager._.nextdns
    ];
  };
}
