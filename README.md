# nixos-config

This was an attempt/experiment at running NixOS as a way to have a unified system install and configuration between my
desktop and laptop. It lasted for about 6 weeks.

## Features

- Declarative disk partitioning using [disko](https://github.com/nix-community/disko)
- tmpfs root file system with the help of [impermanence](https://github.com/nix-community/impermanence)
- Simple host management based around tags with [easy-hosts](https://github.com/tgirlcloud/easy-hosts)
- Auto-generated flake.nix using [flake-file](https://github.com/vic/flake-file)
- Modularized with [flake-parts](https://github.com/hercules-ci/flake-parts)
- Automatic recursive imports with [import-tree](https://github.com/vic/import-tree)

## Conclusion

It's been a fun learning experience, but I feel like I spent too much time tinkering and configuring things, as can be
seen by the list above being quite long, considering that I'm new to Nix too. This is not a comment on Nix or NixOS
forcing complicated setups in any way, but rather an issue that I have, where I can't help myself from going all out and
setting everything up chasing some sort of idea of a _"perfect"_ system. I will go back to Arch Linux.
