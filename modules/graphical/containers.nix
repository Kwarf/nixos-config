{
  flake.modules.nixos.graphical = {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true; # Zed requires the docker command to be present
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };

  flake.modules.homeManager.graphical =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        podman-compose
      ];
    };
}
