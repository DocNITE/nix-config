

{
  description = "Configuration for PC systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.redmibook = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Configuration of system
        ./configuration.nix
      ];
    };
  };
}
