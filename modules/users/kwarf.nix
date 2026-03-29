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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgyUhHbmhbQtQ62dYG35WjSdxErYNTnG9dbexV46l4P kwarf@icarus"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMJGAZco2yp8m42ShyTe9m7GRf5sD7myEUJYFf0jKith kwarf@nyx"
      ];
    };

    homeManager = {
      programs.git = {
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
    };
  };
}
