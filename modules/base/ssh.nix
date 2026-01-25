let
  macbook_air = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIhXZJK+lqHnjSheYCSuGtWbfMqvWgJUsPOyFRPburpZyZiIb8FZEYoxl0ag1kvGhbW18Bk+hFS1UChG43Triqw=";
  nyx = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA3QzDaLjiDHlEpz+3EsjCcL0ZYQU99gR9wILuH7HbHM";
  keys = [
    macbook_air
    nyx
  ];
in
{
  flake.modules.nixos.base = {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    networking.firewall.allowedTCPPorts = [ 22 ];

    users.users.kwarf.openssh.authorizedKeys.keys = keys;
  };
}
