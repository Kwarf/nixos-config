# nixos-config

This all started as a dream of unifying both the configuration and installed packages between my desktop and my laptop.
I thought that this would save me time and effort, but that did unfortunately not become a reality, but I did learn a
few things along the way, so it wasn't a complete waste.

### Features

- Declarative partitioning using [disko](https://github.com/nix-community/disko)
- Secrets management with [sops-nix](https://github.com/Mic92/sops-nix)
- Ephemeral root partition on tmpfs that's wiped on each reboot with the help of [impermanence](https://github.com/nix-community/impermanence)
- Modularized using [Snowfall Lib](https://github.com/snowfallorg/lib)
