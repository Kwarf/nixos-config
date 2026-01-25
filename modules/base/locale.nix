{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      console.keyMap = "sv-latin1";
      i18n.defaultLocale = "en_US.UTF-8";
      time.timeZone = "Europe/Stockholm";
    };
}
