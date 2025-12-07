{
  description = "Portable, hardware-aware NixOS config";

  inputs = {
    # Pin to a specific nixpkgs branch/version
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Hardware database for known machines
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # include home-manager as an input, and let it 'follow' the main nixpkgs branch letting it install packages from nixpkgs instead of keeping its own repository
    home-manager = {
      # url = "github:nix-community/home-manager/release-25.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Systems modules
    systems.url = "github:nix-systems/default";

    # flake-utils for helper functions
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";

    # NixOS on WSL2
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Style/Theme management for NixOS
    # stylix = {
    #   # url = "github:danth/stylix/release-25.05";
    #   url = "github:nix-community/stylix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Nix User Repository: User contributed nix packages
    # nur = {
    #   url = "github:nix-community/NUR";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    flake-utils,
    home-manager,
    nixos-hardware,
    nixos-wsl,
    nixpkgs,
    # nur,
    self,
    # stylix,
    systems,
    ...
  }: let
    linuxSystem = "x86_64-linux";

    # System types to support.
    # supportedSystems = ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];
    supportedSystems = ["x86_64-linux"];

    # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    # Nixpkgs instantiated for supported system types.
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
    nixosConfigurations = {
      # Clone repo with `git clone https://github.com/you/dotfiles.git /etc/nixos`

      # Mac Mini (2014) 16GB Ram 1 TB HD
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#mac-mini-01`
      mac-mini-01 = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        modules = [
          nixos-hardware.nixosModules.apple-macmini-4-1
          ./profiles/mac-mini-16g.nix
          ./modules/users/lee.nix
          ./modules/users/serveradmin.nix

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              users.lee = import ./modules/home/lee;
              # users.clarkgar = import ./modules/home/clarkgar;
            };
          }
        ];
      };

      # Portable USB Drive
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#usb-drive`
      usb-drive = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        modules = [
          ./profiles/usb-drive-samsung-64g.nix
          ./modules/users/lee.nix
        ];
      };

      # SHU Laptop - Lenovo ThinkPad T14s
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#shu-lappy`
      shu-lappy = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t14s
          ./profiles/shu-t14s.nix
          ./modules/users/lee.nix
          ./modules/users/shu-clarkgar.nix

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.users.lee = import ./modules/home/lee;
            # home-manager.users.clarkgar = import ./modules/home/clarkgar;
          }
        ];
      };

      # Windows WSL2
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#wsl2`
      wsl2 = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        modules = [
          nixos-wsl.nixosModules.default
          ./profiles/wsl2.nix
          # ./modules/users/lee.nix
          # ./modules/users/shu-clarkgar.nix
        ];
      };

      # TrueNAS Virtual Machines
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#shu-lappy`
      vm-gaming = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        modules = [
          ./profiles/vm-gaming.nix
          ./modules/users/lee.nix

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.users.lee = import ./modules/home/lee;
            # home-manager.users.clarkgar = import ./modules/home/clarkgar;
          }
        ];
      };

      # Generic (Default) Minimal Config
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#generic`
      generic = nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        modules = [
          ./modules/common.nix
          ./modules/users/lee.nix
          ./modules/users/serveradmin.nix
          ./hosts/default/configuration.nix
          ./modules/desktops/kde-plasma.nix
          ./modules/system/audio-pipewire.nix
          ../modules/development/nano.nix
          ../modules/development/neovim.nix
        ];
      };
    };

    # 👇 Add devShells
    devShells = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      shu-docs = import ./devShells/shu-docs.nix {inherit system pkgs;};
      python = import ./devShells/python.nix {inherit system pkgs;};
    });
  };
}
