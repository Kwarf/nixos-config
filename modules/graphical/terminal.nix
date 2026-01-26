{
  flake.modules.nixos.graphical =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        nerd-fonts.monaspace
      ];
    };

  flake.modules.homeManager.graphical = {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "MonaspiceAr NFM:size=12";
        };
      };
    };
  };
}
