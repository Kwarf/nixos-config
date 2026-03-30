{ config, den, ... }:
let
  secrets = config.my.secrets;
in
{
  den.aspects.kwarf = {
    includes = [
      den._.primary-user
      (den._.user-shell "fish")
    ];

    user = {
      hashedPassword = secrets.hashedUserPassword;
      openssh.authorizedKeys.keys = [
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIhXZJK+lqHnjSheYCSuGtWbfMqvWgJUsPOyFRPburpZyZiIb8FZEYoxl0ag1kvGhbW18Bk+hFS1UChG43Triqw= MacBook-Air@secretive.Jimmy’s-MacBook-Air.local"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgyUhHbmhbQtQ62dYG35WjSdxErYNTnG9dbexV46l4P kwarf@icarus"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE1uNk/boWIBtPpsBs/shTkriyEpWwXjorwwb63Cea2M kwarf@nyx"
      ];
    };

    homeManager = {
      programs.git = {
        enable = true;
        lfs.enable = true;
        settings = {
          user = {
            email = "me@kwarf.com";
            name = "Jimmy Bergström";
          };
          alias = {
            st = "status";
          };
          init = {
            defaultBranch = "main";
          };
          fetch = {
            all = true;
            prune = true;
            pruneTags = true;
          };
          pull = {
            rebase = true;
          };
          push = {
            autoSetupRemote = true;
            followTags = true;
          };
          rebase = {
            autoSquash = true;
            autoStash = true;
            updateRefs = true;
          };
          diff = {
            algorithm = "histogram";
            colorMoved = "plain";
            mnemonicPrefix = true;
            renames = true;
          };
        };
      };
    };
  };
}
