

{
  description = "Configuration for PC systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { nixpkgs, ... }: {
    # Setup for RedmiBook 14 pro
    nixosConfigurations.redmibook = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Configuration of system
        ./configs/redmibook.nix
      ];
    };
  };
}
