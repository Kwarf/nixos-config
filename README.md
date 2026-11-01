# nixos-config

This is my personal NixOS configuration for two AMD machines, `nyx` (desktop) and `icarus` (laptop), with the main goal
of having a unified system install and configuration between them. Most edits are made by Claude, then reviewed
by me before they're applied.

## Goals

I want a system that stays out of my way, so the most important rule is: **boring and explicit beats clever and
abstract.**

- **Hands-off:** I touch the config only when I want something new.
- **Rolling:** tracks `nixos-unstable`, and I run updates myself. No CI or auto-upgrades.
- **In sync:** both machines share the same base, with small per-host differences.
- **Readable:** easy to read in one sitting, by me or anyone else, without knowing any framework.

Abstractions meant to scale to many hosts or users, and generating `flake.nix` or other files from code, are explicit
non-goals.

## Structure

```
flake.nix              # plain flake, one small mkHost helper
hosts/<name>/          # default.nix (imports + host-specific settings), hardware.nix, disko.nix
modules/               # one file per concern: base, desktop, development, gaming, ...
secrets/secrets.yaml   # sops-encrypted, recipients in .sops.yaml
```

There are no frameworks, and no custom `enable` options. A host's `imports` list is the full answer to "what's on this
machine", importing the module is enough to activate it.

## Features

- Declarative disk partitioning using [disko](https://github.com/nix-community/disko)
- Ephemeral root file system with [preservation](https://github.com/nix-community/preservation), keeping a short,
  explicit list of persisted state
- Secrets managed by [sops-nix](https://github.com/Mic92/sops-nix), decrypted with each host's SSH host key
- Apps from nixpkgs by default, with [nix-flatpak](https://github.com/gmodena/nix-flatpak) for a few proprietary,
  internet-facing apps where the sandbox is worth it
- Per-project dev environments using flakes and [nix-direnv](https://github.com/nix-community/nix-direnv)

## Installation instructions

These are just personal notes because I tend to forget these things.

### Remote install

Using [nixos-anywhere](https://github.com/nix-community/nixos-anywhere) to push the configuration for installation over
SSH.

1. Boot a [NixOS ISO](https://nixos.org/download/#nixos-iso) (other systems are supported too, but untested by me). Run
`passwd` to set a password, SSH refuses the empty default, and `nmtui` if it needs Wi-Fi. Then find its address with
`ip a`.
2. Create a new directory under `hosts/` for the new host, taking "inspiration" from one of those already there, and add
it to `flake.nix` with `mkHost`. Then `git add` it, as flakes only see tracked files.
3. Save the new machine's hardware config as the host's `hardware.nix`:
```sh
ssh nixos@<ip address> nixos-generate-config --no-filesystems --show-hardware-config > hosts/<hostname>/hardware.nix
```
4. Create an appropriate `disko.devices` definition in the host's `disko.nix`, see [examples](https://github.com/nix-community/disko/tree/master/example).
Get the disk's ID with `ssh nixos@<ip address> ls -l /dev/disk/by-id`.
5. Generate the host key up front, since secrets have to decrypt on first boot. It can decrypt all of them, so keep it
in `/tmp`, away from the repo and outside Claude's jail. Run this and the next step on the machine you're installing
from, not the new one, and outside the jail. Add the age key to `.sops.yaml`, then re-encrypt with
`sops updatekeys secrets/secrets.yaml`:
```sh
nix shell nixpkgs#sops nixpkgs#ssh-to-age
mkdir -p /tmp/extra/persistent/etc/ssh
ssh-keygen -t ed25519 -N "" -f /tmp/extra/persistent/etc/ssh/ssh_host_ed25519_key
ssh-to-age < /tmp/extra/persistent/etc/ssh/ssh_host_ed25519_key.pub
```
6. Run the installation, then delete `/tmp/extra`. It asks for the password of the live system, and later for the new
disk encryption password, so stay around:
```sh
nix run github:nix-community/nixos-anywhere -- --extra-files /tmp/extra --flake .#<hostname> --target-host nixos@<ip address>
```
7. Profit. Wait for it to finish and reboot.

It's possible to pass either `remote` or `local` as a `--build-on` option to `nixos-anywhere`, which could be nice
depending on which machine is faster or has a better connection.
