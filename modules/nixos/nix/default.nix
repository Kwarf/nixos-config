{
  config,
  inputs,
  pkgs,
  ...
}: {
  config = {
    nix.settings.experimental-features = ["nix-command" "flakes"];

    environment.systemPackages = with pkgs; [
      git
      neovim
      inputs.alejandra.defaultPackage.${stdenv.hostPlatform.system}
    ];
  };
}
