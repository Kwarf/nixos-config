{
  flake.modules.homeManager.graphical =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        wiremix
      ];

      catppuccin.waybar.enable = true;

      programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            modules-left = [
              "niri/workspaces"
            ];
            modules-center = [
              "niri/window"
            ];
            modules-right = [
              "pulseaudio"
              "cpu"
              "memory"
              "battery"
              "tray"
              "clock"
            ];
            pulseaudio = {
              on-click = "footclient --app-id=wiremix wiremix";
              format = "{icon} {volume}%";
              format-bluetooth = "{icon}󰂯 {volume}%";
              format-muted = "";
              format-icons = {
                default = [
                  ""
                  ""
                  ""
                ];
              };
            };
            cpu = {
              format = " {usage}%";
            };
            memory = {
              format = " {}%";
            };
            battery = {
              states = {
                good = 70;
                warning = 30;
                critical = 15;
              };
              format = "{icon} {capacity}%";
              format-full = "{icon} {capacity}%";
              format-charging = "󰂄 {capacity}%";
              format-plugged = " {capacity}%";
              format-alt = "{power}W ({icon} {time})";
              format-icons = [
                "󰁻"
                "󰁽"
                "󰁿"
                "󰂁"
                "󰁹"
              ];
            };
            clock = {
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
              format-alt = "{:%Y-%m-%d}";
            };
          };
        };
        style = ''
          * {
              font-family: MonaspiceNe NF;
              font-size: 14px;
          }

          #waybar {
              background: @mantle;
              color: @text;
          }

          #workspaces {
              border-radius: 1rem;
              margin: 5px;
              padding: 0 0.5rem;
              background-color: @surface1;
          }

          #workspaces button {
              border-radius: 1rem;
              padding: 0.2rem 0.5rem;
          }

          #workspaces button.active {
              color: @mauve;
              background-color: @surface2;
          }

          #pulseaudio,
          #cpu,
          #memory,
          #battery,
          #tray,
          #clock {
              border-radius: 1rem;
              margin: 5px;
              padding: 0 1rem;
              background-color: @surface1;
          }

          #pulseaudio.muted {
              background-color: @red;
              color: @mantle;
          }

          #cpu {
              border-radius: 1rem 0 0 1rem;
              margin-right: 0;
              padding-right: 0.5rem;
          }

          #memory {
              border-radius: 0 1rem 1rem 0;
              margin-left: 0;
              padding-left: 0.5rem;
          }

          #battery {
              color: @green;
          }

          #battery.charging {
              color: @green;
          }

          #battery.warning:not(.charging) {
              color: @yellow;
          }

          #battery.critical:not(.charging) {
              color: @red;
          }
        '';
      };
    };
}
