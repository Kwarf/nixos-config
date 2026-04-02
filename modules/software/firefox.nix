{ config, ... }:
let
  kagiToken = config.my.secrets.kagi.token;
in
{
  den.aspects.software.provides.firefox = {
    homeManager = {
      xdg.mimeApps.defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };

      programs.firefox = {
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
          GenerativeAI = {
            Enabled = false;
            Locked = true;
          };
          ExtensionSettings = {
            "*".installation_mode = "blocked";
            # uBlock Origin
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
              default_area = "menupanel";
              private_browsing = true;
            };
            # Proton Pass
            "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
              installation_mode = "force_installed";
              default_area = "navbar";
              private_browsing = true;
            };
            # SponsorBlock
            "sponsorBlocker@ajay.app" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
              installation_mode = "force_installed";
              default_area = "menupanel";
              private_browsing = true;
            };
            # Consent-O-Matic
            "gdpr@cavi.au.dk" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi";
              installation_mode = "force_installed";
              default_area = "menupanel";
              private_browsing = true;
            };
          };
          FirefoxHome = {
            Search = true;
            TopSites = false;
            SponsoredTopSites = false;
            Highlights = false;
            Pocket = false;
            Stories = false;
            SponsoredPocket = false;
            SponsoredStories = false;
            Snippets = false;
            Locked = true;
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
          SearchEngines = {
            Default = "Kagi Search";
            Add = [
              {
                Name = "Kagi Search";
                Alias = "@kagi";
                Method = "GET";
                IconURL = "https://kagi.com/favicon.ico";
                URLTemplate = "https://kagi.com/search?token=${kagiToken}&q={searchTerms}";
                SuggestURLTemplate = "https://kagisuggest.com/api/autosuggest?q={searchTerms}";
              }
              {
                Name = "NixOS Packages";
                Alias = "@np";
                Method = "GET";
                IconURL = "https://search.nixos.org/favicon.png";
                URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
              }
              {
                Name = "NixOS Options";
                Alias = "@no";
                Method = "GET";
                IconURL = "https://search.nixos.org/favicon.png";
                URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
              }
              {
                Name = "Home Manager";
                Alias = "@hm";
                Method = "GET";
                IconURL = "https://home-manager-options.extranix.com/images/favicon.png";
                URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
              }
            ];
            Remove = [
              "Google"
              "Bing"
              "DuckDuckGo"
              "Ecosia"
              "Perplexity"
            ];
          };
        };
      };
    };
  };
}
