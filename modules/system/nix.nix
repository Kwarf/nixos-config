{
  den.aspects.system.provides.nix = {
    nixos =
      { pkgs, ... }:
      {
        nix = {
          settings = {
            auto-optimise-store = true;
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

        programs.nh = {
          enable = true;
          clean.enable = true;
          clean.extraArgs = "--keep-since 3d --keep 3";
          flake = "/home/kwarf/Developer/nixos-config";
        };
      };
  };
}
