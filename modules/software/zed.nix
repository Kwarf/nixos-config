{
  den.aspects.software.provides.zed = {
    homeManager =
      { pkgs, ... }:
      {
        programs.zed-editor = {
          enable = true;
          extensions = [
            "nix"
          ];
          extraPackages = with pkgs; [
            nixd
            nixfmt
          ];
        };
      };
  };
}
