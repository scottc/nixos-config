{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager"; # unstable
      # url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix2411pkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    # See flake.lock for exact pinned versions.
  };

  outputs = { nixpkgs, home-manager, nixos-hardware, ... } @ inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # nix2411pkgs = inputs.nix2411pkgs.legacyPackages.${system};
  in
  {

    # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    
    # homeConfigurations.anon = home-manager.lib.homeManagerConfiguration {
    #   inherit pkgs;
    #   
    #   modules = [ ./home.nix ];
    # };
    
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      # system = "x86_64-linux";
      specialArgs = { inherit inputs system; };
      modules = [ 
        ./configuration.nix
        
        # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
        # nixos-hardware.nixosModules.lenovo-thinkpad-t550
        
        # ./hardware-configuration.nix # don't need to import here, already imported via ./configuration.nix
        # ({ pkgs, ... }: {
        #   programs.vim.defaultEditor = true;
        # })
      ];
    };
  };
}
