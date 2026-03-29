{
  den.aspects.services.provides.ssh = {
    provides = {
      server = {
        nixos.services.openssh = {
          enable = true;
          openFirewall = true;
          settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
          };
        };
      };
    };
  };
}
