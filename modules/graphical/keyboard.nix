{
  flake.modules.nixos.graphical = {
    services.xserver.xkb.options = "lv5:caps_switch";
  };
}
