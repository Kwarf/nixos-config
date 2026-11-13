{ inputs, pkgs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  # For editing secrets/secrets.yaml, see the README
  environment.systemPackages = [
    pkgs.sops
    pkgs.ssh-to-age
  ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;

    # The real file, /etc/ssh only has a preservation symlink that may not exist yet during activation
    age.sshKeyPaths = [ "/persistent/etc/ssh/ssh_host_ed25519_key" ];
    gnupg.sshKeyPaths = [ ];
  };
}
