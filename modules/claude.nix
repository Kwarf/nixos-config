{ inputs, pkgs, ... }:
let
  # Jails all of Claude Code, including its hooks and its MCP and LSP servers. Only what's listed
  # here exists inside. The network stays open, and the built-in sandbox isn't used.
  claude-boxed = pkgs.writeShellScriptBin "claude" ''
    # The VS Code extension passes its bundled binary, which can't run on NixOS, as an argument
    case "''${1:-}" in
      */resources/native-binary/claude) shift ;;
    esac

    project=$(${pkgs.git}/bin/git rev-parse --show-toplevel 2>/dev/null || pwd)

    # Binding home or a parent of it would undo the empty home below
    case "$HOME/" in
      "''${project%/}/"*)
        echo "claude: refusing to use $project as the project" >&2
        exit 1
        ;;
    esac

    mkdir -p "$HOME/.claude" "$HOME/.cache/claude-box"
    [ -e "$HOME/.claude/settings.json" ] || echo '{}' > "$HOME/.claude/settings.json"

    # The environment is inherited so devShell tools work, keep secrets out of .envrc.
    # CLAUDE_CONFIG_DIR moves .claude.json into ~/.claude, as saving it renames over the file, which
    # a single-file bind can't do. settings.json is read-only so Claude can't loosen its prompts,
    # and the hooks and config in .git because they run outside the jail. The Wayland socket is for
    # the clipboard, which it exposes. Its path is fixed, as $WAYLAND_DISPLAY is unset over SSH, and
    # binding "$XDG_RUNTIME_DIR/" instead would expose the SSH agent and D-Bus.
    exec ${pkgs.bubblewrap}/bin/bwrap \
      --unshare-all --share-net \
      --die-with-parent \
      --setenv CLAUDE_CONFIG_DIR "$HOME/.claude" \
      --ro-bind /nix/store /nix/store \
      --ro-bind /run/current-system /run/current-system \
      --ro-bind /run/systemd/resolve /run/systemd/resolve \
      --ro-bind /etc /etc \
      --ro-bind /bin /bin \
      --ro-bind /usr/bin/env /usr/bin/env \
      --proc /proc \
      --dev /dev \
      --tmpfs /tmp \
      --tmpfs "$HOME" \
      --bind "$HOME/.claude" "$HOME/.claude" \
      --ro-bind "$HOME/.claude/settings.json" "$HOME/.claude/settings.json" \
      --bind "$HOME/.cache/claude-box" "$HOME/.cache" \
      --ro-bind-try "$HOME/.gitconfig" "$HOME/.gitconfig" \
      --ro-bind-try "$HOME/.config/git" "$HOME/.config/git" \
      --ro-bind-try "/run/user/$UID/wayland-0" "/run/user/$UID/wayland-0" \
      --bind "$project" "$project" \
      --ro-bind-try "$project/.git/hooks" "$project/.git/hooks" \
      --ro-bind-try "$project/.git/config" "$project/.git/config" \
      --chdir "$PWD" \
      ${pkgs.claude-code}/bin/claude "$@"
  '';
in
{
  nixpkgs.overlays = [ inputs.claude-code.overlays.default ];

  environment.systemPackages = [
    claude-boxed
    pkgs.wl-clipboard
  ];
}
