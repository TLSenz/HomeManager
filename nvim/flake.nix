{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { nixpkgs, home-manager, nvf, ... }: {
    homeConfigurations."thalium@cachyos-x86_64" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        # Make the NVF flake available in home.nix
        extraSpecialArgs = { inherit nvf; };

        modules = [
          # Call the NVF module with pkgs so Home-Manager can register options
          (nvf.homeManagerModules.default { pkgs = pkgs; })
          ../home.nix
        ];
      };
  };
}


