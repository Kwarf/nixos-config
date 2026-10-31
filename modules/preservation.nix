{ inputs, ... }:
{
  imports = [ inputs.preservation.nixosModules.default ];

  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persistent".neededForBoot = true;

  # /etc/machine-id is preserved, so there's nothing for this unit to commit
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

  preservation = {
    enable = true;
    preserveAt."/persistent" = {
      files = [
        # Must be in place before systemd starts using it
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }

        # Keeps the machine's SSH identity stable across boots
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          how = "symlink";
          configureParent = true;
        }
        {
          file = "/etc/ssh/ssh_host_rsa_key";
          how = "symlink";
          configureParent = true;
        }
      ];
      directories = [
        # UID/GID allocations, without this users and groups can get renumbered
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }

        "/var/log"
        "/var/lib/systemd/timers" # So persistent timers know when they last ran
        "/var/lib/systemd/coredump"

        "/var/lib/bluetooth"
        "/etc/NetworkManager/system-connections"
        "/var/lib/NetworkManager"
      ];
    };
  };
}
