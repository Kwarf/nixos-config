{
  den.aspects.system.provides.nix = {
    nixos =
      { pkgs, ... }:
      {
        nix = {
          settings = {
            experimental-features = [
              "nix-command"
              "flakes"
            ];
          };
          channel.enable = false;
        };

        environment.systemPackages = with pkgs; [
          neovim
          git
          git-crypt
        ];
      };
  };
}
