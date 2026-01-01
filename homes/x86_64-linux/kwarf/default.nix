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
    pwvucontrol
    sops
  ];

  programs = {
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

    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
