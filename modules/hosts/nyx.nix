{ den, ... }:
{
  den.hosts.x86_64-linux.nyx.users.kwarf = { };

  den.aspects.nyx = {
    includes = [
      den.aspects.system._.bootloader._.systemd-boot
      den.aspects.system._.kernel._."6_18" # FIXME: Change this to `latest` whenever 6.19 is fixed to boot on this machine

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

      den.aspects.services._.nts
      den.aspects.services._.nts._.servers._.stockholm
      den.aspects.services._.nts._.servers._.sundsvall
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
        ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];

        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

        # Disable USB wakeup, without this suspend would instantly wake up again
        services.udev.extraRules = ''
          ACTION=="add", SUBSYSTEM=="pci", ATTR{class}=="0x0c0330", ATTR{power/wakeup}="disabled"
        '';

        disko.devices = {
          disk = {
            main = {
              device = "/dev/disk/by-id/nvme-KINGSTON_SFYR2S2T0_50026B7283B1266D";
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
