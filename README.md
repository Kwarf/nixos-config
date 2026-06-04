> [!NOTE]
> I'm archiving this _again_, as I'm distro hopping to [Fedora Silverblue](https://fedoraproject.org/atomic-desktops/silverblue/) instead.
> I feel like that should fit me pretty well, as I like the idea of immutability in the base system then using separate
> containers for each project I'm working on to keep things neat and separate. I'm also one of those weird people who
> appreciate the sandboxing of Flatpak apps. I obviously already had essentially that same setup through this config,
> but I think I want something more hands-off.

---

# nixos-config

This is my personal NixOS configuration, with the main goal of having  a unified system install and configuration
between my desktop and laptop.

## Features

- Dentritic aspect-oriented structure thanks to [den](https://github.com/vic/den)
  - Automatic recursive imports with [import-tree](https://github.com/vic/import-tree)
  - Auto-generated flake.nix using [flake-file](https://github.com/vic/flake-file)
  - Modularized with [flake-parts](https://github.com/hercules-ci/flake-parts)
- Declarative disk partitioning using [disko](https://github.com/nix-community/disko)
- tmpfs root file system through [impermanence](https://github.com/nix-community/impermanence)
- Declarative [Flatpak](https://flatpak.org/) management with [nix-flatpak](https://github.com/gmodena/nix-flatpak)

## Inspired by

- https://codeberg.org/Adda/nixos-config
- https://github.com/augustocdias/dotfiles
- https://github.com/henriquekirchheck/nixos-flake

## Installation instructions

These are just personal notes because I tend to forget these things.

### Remote install

Using [nixos-anywhere](https://github.com/nix-community/nixos-anywhere) to push the configuration for installation over
SSH.

1. Boot a [NixOS ISO](https://nixos.org/download/#nixos-iso) (other systems are supported too, but untested by me).
2. Create a new file under `modules/hosts/` for the new host, taking "inspiration" from one of those already there.
3. Run `nixos-generate-config --no-filesystems --show-hardware-config` on the new machine, and add those options to the
host configuration.
4. Create an appropriate `disko.devices` definition, see [examples](https://github.com/nix-community/disko/tree/master/example).
5. Run the installation:
```sh
nix run github:nix-community/nixos-anywhere -- --flake .#<hostname> --target-host nixos@<ip address>
```
6. Profit. Wait for it to finish and reboot.

It's possible to pass either `remote` or `local` as a `--build-on` option to `nixos-anywhere`, which could be nice
depending on which machine is faster or has a better connection.
