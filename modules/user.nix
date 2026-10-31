{ config, pkgs, ... }:
{
  programs.fish.enable = true;

  sops.secrets.kwarf-password.neededForUsers = true;

  users.mutableUsers = false;
  users.users.kwarf = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIhXZJK+lqHnjSheYCSuGtWbfMqvWgJUsPOyFRPburpZyZiIb8FZEYoxl0ag1kvGhbW18Bk+hFS1UChG43Triqw= MacBook-Air@secretive.Jimmy’s-MacBook-Air.local"
    ];
    hashedPasswordFile = config.sops.secrets.kwarf-password.path;
  };
}
