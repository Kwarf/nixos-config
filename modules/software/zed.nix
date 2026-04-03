{
  den.aspects.software.provides.zed = {
    homeManager =
      { pkgs, ... }:
      {
        programs.zed-editor = {
          enable = true;
          extensions = [
            "nix"
          ];
          extraPackages = with pkgs; [
            nixd
            nixfmt
          ];
          userSettings = {
            buffer_font_family = "Adwaita Mono";
            buffer_font_size = 14;
            ui_font_family = "Adwaita Sans";
            ui_font_size = 16;
            wrap_guides = [ 120 ];
            show_whitespaces = "boundary";
            tab_bar = {
              show_pinned_tabs_in_separate_row = true;
              show_nav_history_buttons = false;
            };
            tabs = {
              git_status = true;
            };
            minimap = {
              show = "auto";
            };
            collaboration_panel = {
              button = false;
            };
            auto_update = false;
            telemetry = {
              diagnostics = false;
              metrics = false;
            };
            languages = {
              "Nix" = {
                formatter = {
                  external = {
                    command = "nixfmt";
                    arguments = [
                      "--quiet"
                      "--"
                    ];
                  };
                };
                language_servers = [
                  "nixd"
                  "!nil"
                ];
              };
            };
          };
        };
      };
  };
}
