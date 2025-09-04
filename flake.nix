{
  description = "Portable, hardware-aware NixOS config";

  inputs = {
    # Pin to a specific nixpkgs branch/version
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Hardware database for known machines
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # flake-utils for helper functions
    flake-utils.url = "github:numtide/flake-utils";

    # include home-manager as an input, and let it 'follow' the main nixpkgs branch letting it install packages from nixpkgs instead of keeping its own repository
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS on WSL2
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Systems modules
    systems.url = "github:nix-systems/default";

    # Style/Theme management for NixOS
    # stylix.url = "github:danth/stylix";
    # stylix.inputs.nixpkgs.follows = "nixpkgs";

    # # Nix User Repository: User contributed nix packages
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
    nur,
    self, 
    # stylix,
    systems,
    ... 
  }:
  let
    mySystem = "x86_64-linux";
    pkgsFor = system: import nixpkgs { inherit system; };
  in {
    nixosConfigurations = {
      # Clone repo with `git clone https://github.com/you/dotfiles.git /etc/nixos`

      # Mac Mini (2014) 16GB Ram 1 TB HD
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#mac-mini-01`
      mac-mini-01 = nixpkgs.lib.nixosSystem {
        system = mySystem;
        modules = [
          ./profiles/mac-mini-16g.nix
          ./modules/users/lee.nix
          ./modules/users/serveradmin.nix
          # stylix.nixosModules.stylix
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
          # ./modules/users/lee.nix
          # ./modules/users/shu-clarkgar.nix
        ];
      };

      # Generic (Default) Minimal Config
      # Switch with `sudo nixos-rebuild switch --flake /etc/nixos#generic`
      generic = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common.nix
          ./modules/users/lee.nix
          ./modules/users/serveradmin.nix
          ./hosts/default/configuration.nix
          ./modules/desktops/kde-plasma.nix
          ./modules/system/audio-pipewire.nix
        ];
      };
    };

    # 👇 Add devShells for mkdocs project
    devShells = {
      shu-docs = pkgs.mkShell {
        buildInputs = [
          pkgs.python312
          python.pkgs.pip
          python.pkgs.virtualenv
          python.pkgs.mkdocs
          python.pkgs.mkdocs-material
        ];
  
        shellHook = ''
          # Set up a throwaway venv if one doesn't exist
          if [ ! -d .venv ]; then
            echo "⚙️ Creating Python venv for MkDocs..."
            virtualenv .venv
            .venv/bin/pip install -r requirements.txt
          fi
          source .venv/bin/activate
          echo "✅ MkDocs dev environment ready. Run: mkdocs serve"
        '';
      };
    };
  };
}
