{config, ...}: let
  dotfiles = "${config.home.homeDirectory}/nix-config/homes/x86_64-linux/kwarf/dotfiles";
in {
  xdg.configFile."qtile/config.py".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/qtile/config.py";
}
