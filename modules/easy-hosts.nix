{ self, inputs, ... }:
{
  flake-file.inputs.easy-hosts.url = "github:tgirlcloud/easy-hosts";
  imports = [ inputs.easy-hosts.flakeModule ];

  easy-hosts = {
    shared = {
      modules = with inputs; [
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        self.modules.nixos.base
      ];
    };

    perTag = tag: {
      modules = [
        self.modules.nixos.${tag}
      ];
    };

    hosts = {
      icarus = {
        tags = [
          "laptop"
        ];
      };
    };
  };
}
