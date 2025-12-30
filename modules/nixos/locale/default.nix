{config, ...}: {
  config = {
    time.timeZone = "Europe/Stockholm";
    console.keyMap = "sv-latin1";
    services.xserver = {
      xkb.layout = "se";
    };
    environment.variables = {
      XKB_DEFAULT_LAYOUT = "se";
    };
  };
}
