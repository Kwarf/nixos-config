{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./dotfiles
  ];

  home.username = "kwarf";
  home.homeDirectory = "/home/kwarf";

  home.packages = with pkgs; [
    age
    grim # Wayland screenshot tool
    slurp # Wayland region selection (for screenshots)
    sops
    wev # Wayland event viewer
    wiremix # TUI mixer for PipeWire
    wl-clipboard # wl-copy / wl-paste
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    name = "catppuccin-latte-dark-cursors";
    package = pkgs.catppuccin-cursors.latteDark;
  };

  catppuccin = {
    flavor = "macchiato";
    fish.enable = true;
    foot.enable = true;
    gitui.enable = true;
  };

  programs = {
    anyrun = {
      enable = true;
      config = {
        y = {fraction = 0.3;};
        hidePluginInfo = true;
        plugins = [
          "${pkgs.anyrun}/lib/libapplications.so"
        ];
      };
    };

    firefox = {
      enable = true;
      policies = {
        AutofillCreditCardEnabled = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        ExtensionSettings = {
          "*".installation_mode = "blocked";
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # Proton Pass
          "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
            installation_mode = "force_installed";
          };
        };
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        PasswordManagerEnabled = false;
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
    };

    fish = {
      enable = true;
    };

    foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "MonaspiceAr NFM:size=12";
        };
      };
    };

    git = {
      enable = true;
      settings = {
        user = {
          email = "me@kwarf.com";
          name = "Jimmy Bergström";
        };

        alias = {
          st = "status";
        };
      };
    };

    gitui = {
      enable = true;
    };

    iamb = {
      enable = true;
      settings = {
        default_profile = "kwarf";
        profiles.kwarf = {
          user_id = "@kwarf:matrix.znurre.com";
          url = "https://matrix.znurre.com";
        };
        settings = {
          user_gutter_width = 16;
          username_display = "localpart";
          notifications.enabled = true;
        };
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  services = {
    wob = {
      enable = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
