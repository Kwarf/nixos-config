{
  flake-file.inputs.impermanence = {
    url = "github:nix-community/impermanence";
    inputs.nixpkgs.follows = "";
    inputs.home-manager.follows = "";
  };

  flake.modules.nixos.base = {
    fileSystems."/home".neededForBoot = true;
    fileSystems."/persistent".neededForBoot = true;

    environment.persistence."/persistent" = {
      hideMounts = true;
      directories = [
        "/var/lib/nixos"
      ];
      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };
  };
}
