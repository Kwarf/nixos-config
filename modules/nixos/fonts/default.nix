{
  config,
  pkgs,
  ...
}: {
  config.fonts.packages = with pkgs; [
    nerd-fonts.monaspace
    noto-fonts
    noto-fonts-color-emoji
  ];
}
