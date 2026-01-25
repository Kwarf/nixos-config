{
  flake.modules.nixos.base =
    {
      pkgs,
      config,
      ...
    }:
    let
      secrets = config.my.secrets;
    in
    {
      users = {
        mutableUsers = false;
        users.kwarf = {
          isNormalUser = true;
          hashedPassword = secrets.hashedUserPassword;
          extraGroups = [
            "networkmanager" # Allow nmtui usage
            "wheel" # Allow sudo
          ];
          packages = with pkgs; [
          ];
        };
      };
    };
}
