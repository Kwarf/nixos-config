{
  config,
  pkgs,
  ...
}: {
  config.users = {
    mutableUsers = false;
    users.kwarf = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.hashedLocalUserPassword.path;
      extraGroups = ["seat" "wheel"];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIhXZJK+lqHnjSheYCSuGtWbfMqvWgJUsPOyFRPburpZyZiIb8FZEYoxl0ag1kvGhbW18Bk+hFS1UChG43Triqw= MacBook-Air@secretive.Jimmy’s-MacBook-Air.local"
      ];
    };
  };
}
