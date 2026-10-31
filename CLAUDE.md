@README.md

# Instructions for agents

The README above covers the goals, structure and non-goals. Its most important rule applies to every change: boring
and explicit beats clever and abstract. This file adds the rules and decisions it doesn't cover.

## Rules

- `flake.nix` is written by hand, and no frameworks like flake-parts, den, import-tree or flake-file.
- Don't define a `my.*` namespace.
- Lean on the module system's merging (lists concatenate, attrsets merge). Use `lib.mkDefault` or `lib.mkForce` only for real conflicts.
- No helper functions besides `mkHost`. A few duplicated lines in host files are fine.
- Don't add a flake input without a clear need. Prefer upstream NixOS options over community modules.
- No home-manager unless there's a clear need it alone solves. Configure system-level things here, and keep per-user settings like my git config in my dotfiles, outside this repo. GNOME is the exception: its settings are dconf defaults in `modules/desktop.nix`, which I can still override.

## Decisions

- **Updates:** I run them myself with `nix flake update`, then `nh os switch`. The one exception is Flatpak apps, which update on every boot and switch.
- **Rollback and cleanup:** systemd-boot with a `configurationLimit` of 10, matching the automatic weekly `nh clean` that keeps the last 7 days and at least 10 generations. Use that instead of `nix.gc`. Put the git revision in `system.nixos.label`.
- **Persistence:** a module declares the paths it needs itself.
- **Flathub exception:** OBS isn't proprietary, but Steam is a Flatpak, so OBS and its capture layer stay Flatpaks too, on the same runtime branch as Steam.
- **Secrets:** the host key is read from `/persistent`, because the `/etc/ssh` symlink may not exist yet during activation. Values must be quoted strings, as sops-nix rejects numbers. Never put secret values in the Nix store. Wi-Fi profiles aren't declared, they're created through NetworkManager and persisted. The password uses `hashedPasswordFile`, and the NextDNS ID uses `sops.templates`. The Kagi token stays out of Nix.
- **ROCm is scoped per package** (e.g. `pkgsRocm.blender`). Don't set `nixpkgs.config.rocmSupport` globally.
- **Kernel:** `linuxPackages_latest`.
- **Dev environments:** the system only enables direnv and nix-direnv.
- **Claude Code:** enable its built-in sandbox, which needs `bubblewrap` and `socat` installed.
- Keep `system.stateVersion` at `26.05` (the installed version).

## Working in this repo

- Flakes only see tracked files, so new files need `git add`. Add them by name: the sandbox leaves placeholder dotfiles in the repo root. Don't commit unless I ask, and commit directly to `master` unless I ask for a branch.
- Adding a persisted path needs `nh os boot` and a reboot, not `switch`: the mount may not be active yet, so data could land on the tmpfs root.
- In the sandbox, `nix` can't reach the daemon and network access varies. Check changes with `nix eval --store <scratch dir>`, using `--override-input` with local store paths when inputs can't be fetched. That doesn't replace a real rebuild and reboot.
- When debugging, first check which generation is running with `/run/current-system`. It may not be the latest build.
