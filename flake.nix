{
  description = "Portable, hardware-aware NixOS config";

  inputs = {
    # Pin to a specific nixpkgs branch/version
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # Optional hardware database for known machines
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # Optional: pin flake-utils for helper functions
    # flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixos-hardware, flake-utils, ... }: {
  # flake-utils.lib.eachDefaultSystem (system: {
    nixosConfigurations = {
      # Clone repo with `git clone https://github.com/you/dotfiles.git /etc/nixos`

      # Mac Mini (2014) 16GB Ram 1 TB HD
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#mac-mini-01`
      mac-mini-01 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common.nix
          ./hosts/mac-mini/configuration.nix
          ./modules/x11.nix
          ./modules/kde-plasma.nix
          ./modules/firefox.nix
          ./modules/bluetooth.nix
          ./modules/audio-pipewire.nix
        ];
      };

      # SHU Laptop - Lenovo ThinkPad T14s
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#shu-lappy`
      shu-lappy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common.nix
          ./hosts/shu-laptop/configuration.nix
          ./modules/kde-plasma.nix
          ./modules/bluetooth.nix
          ./modules/audio-pipewire.nix
        ];
      };

      # Portable USB Drive
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#usb-drive`
      usb-drive = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common.nix
          ./hosts/usb-drive/configuration.nix
          ./modules/kde-plasma.nix
          ./modules/bluetooth.nix
          ./modules/audio-pipewire.nix
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
        ];
      };

    };
  # });
  };
}
