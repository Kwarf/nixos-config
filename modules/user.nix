{ config, pkgs, ... }:
{
  programs.fish.enable = true;

  sops.secrets.kwarf-password.neededForUsers = true;

  users.mutableUsers = false;
  users.users.kwarf = {
    isNormalUser = true;
    description = "Jimmy Bergström";
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIhXZJK+lqHnjSheYCSuGtWbfMqvWgJUsPOyFRPburpZyZiIb8FZEYoxl0ag1kvGhbW18Bk+hFS1UChG43Triqw= MacBook-Air@secretive.Jimmy’s-MacBook-Air.local"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGJZP2v8ZhVYc0gAU07ABKcf+0p16uQ1SGUCklunI5RRUkqvzkjaOb9vFtDNooFlvHgoKI/TYW00PO3E2P2vQQU= kwarf@nyx"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBAY/5Hlli9NNiz2zsdT8R4FtwJfch4cMDUkdxvuDkq1k4Usv5oB1OaI6ClU7TuVn6e+AY3ohHPxG8kCKmKQbvzU= kwarf@icarus"
    ];
    hashedPasswordFile = config.sops.secrets.kwarf-password.path;
  };
}
