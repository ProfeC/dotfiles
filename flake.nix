{
  description = "Portable, hardware-aware NixOS config";

  inputs = {
    # Pin to a specific nixpkgs branch/version
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Optional hardware database for known machines
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # Optional: pin flake-utils for helper functions
    flake-utils.url = "github:numtide/flake-utils";

    # Optional: NixOS on WSL2
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Optional: Systems modules
    systems.url = "github:nix-systems/default";
  };

  outputs = { 
    self, 
    nixpkgs,
    systems,
    nixos-wsl, 
    nixos-hardware, 
    flake-utils, 
    ... 
  }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      # Clone repo with `git clone https://github.com/you/dotfiles.git /etc/nixos`

      # Mac Mini (2014) 16GB Ram 1 TB HD
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#mac-mini-01`
      mac-mini-01 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./profiles/mac-mini-16g.nix
          ./modules/users/lee.nix
          ./modules/users/serveradmin.nix
        ];
      };

      # Portable USB Drive
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#usb-drive`
      usb-drive = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./profiles/usb-drive-samsung-64g.nix
          ./modules/users/lee.nix
        ];
      };

      # Generic (Default) Minimal Config
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#usb-drive`
      generic = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common.nix
          ./hosts/default/configuration.nix
          ./modules/kde-plasma.nix
          ./modules/audio-pipewire.nix
          ./modules/users/lee.nix
          ./modules/users/serveradmin
        ];
      };

      # SHU Laptop - Lenovo ThinkPad T14s
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#shu-lappy`
      shu-lappy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./profiles/shu-t14s.nix
          ./modules/users/lee.nix
          ./modules/users/shu-clarkgar.nix
        ];
      };

      # Windows WSL2
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#wsl2`
      wsl2 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          ./profiles/wsl2.nix
          ./modules/users/lee.nix
          ./modules/users/shu-clarkgar.nix
        ];
      };

    };
  };
}
