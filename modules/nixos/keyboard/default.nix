{config, ...}: {
  config.services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            # Caps Lock activates the hyper layer if held, or acts as Esc when tapped
            capslock = "overload(hyper, esc)";
          };
          # The hyper layer will hold Ctrl+Meta+Shift
          "hyper:C-M-S" = {};
          # Pressing both shift keys will toggle Caps Lock
          shift = {
            leftshift = "capslock";
            rightshift = "capslock";
          };
        };
      };
    };
  };
}
