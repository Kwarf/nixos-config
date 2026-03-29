{ den, ... }:
{
  den.hosts.x86_64-linux.icarus.users.kwarf = { };

  den.aspects.icarus = {
    includes = [
      den.aspects.system._.bootloader._.systemd-boot
      den.aspects.system._.kernel._.latest
      den.aspects.system._.zswap

      (den.aspects.system._.impermanence._.addPersistance "/persistent")
      (den.aspects.system._.impermanence._.addOptions "/persistent" {
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
      })

      den.aspects.system._.networking._.wifi

      den.aspects.services._.ssh._.server

      den.aspects.profiles._.graphical
    ];

    # This includes aspects with homeManager for all users
    provides.to-users.includes = [ den.aspects.profiles._.graphical ];

    nixos =
      {
        config,
        lib,
        modulesPath,
        ...
      }:
      {
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];

        boot.initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
          "thunderbolt"
        ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];

        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

        disko.devices = {
          disk = {
            main = {
              device = "/dev/disk/by-id/nvme-KBG6AZNV1T02_LA_KIOXIA_9FHPS1L8Z35W";
              type = "disk";
              content = {
                type = "gpt";
                partitions = {
                  ESP = {
                    type = "EF00";
                    size = "1G";
                    content = {
                      type = "filesystem";
                      format = "vfat";
                      mountpoint = "/boot";
                      mountOptions = [ "umask=0077" ];
                    };
                  };
                  luks = {
                    size = "100%";
                    content = {
                      type = "luks";
                      name = "crypted";
                      settings.allowDiscards = true;
                      content = {
                        type = "btrfs";
                        extraArgs = [ "-f" ]; # Override existing partition
                        subvolumes = {
                          "home" = {
                            mountpoint = "/home";
                            mountOptions = [
                              "compress=zstd"
                              "noatime"
                            ];
                          };
                          "nix" = {
                            mountpoint = "/nix";
                            mountOptions = [
                              "compress=zstd"
                              "noatime"
                            ];
                          };
                          "persistent" = {
                            mountpoint = "/persistent";
                            mountOptions = [
                              "compress=zstd"
                              "noatime"
                            ];
                          };
                          "swap" = {
                            mountpoint = "/swap";
                            swap = {
                              swapfile.size = "16G";
                            };
                          };
                        };
                      };
                    };
                  };
                };
              };
            };
          };
          nodev."/" = {
            fsType = "tmpfs";
            mountOptions = [
              "size=2G"
              "defaults"
              "mode=755"
            ];
          };
        };
      };
  };
}
