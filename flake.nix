{
  description = "Portable, hardware-aware NixOS config";

  inputs = {
    # Pin to a specific nixpkgs branch/version
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # Optional hardware database for known machines
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # Optional: pin flake-utils for helper functions
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";

    # Reads DMI info from /sys to detect hardware model
    detectModel = builtins.readFile "/sys/class/dmi/id/product_name";
    trim = str: builtins.replaceStrings ["\n" "\r"] [""] str;
    model = trim detectModel;

    # Choose profile based on detected model
    profile = if builtins.match ".*Macmini.*" model != null then
      ./profiles/macmini.nix
      ./configuration.nix
    else if builtins.match ".*ThinkPad.*" model != null then
      ./profiles/shu-laptop.nix
    else
      ./profiles/generic.nix;

  in {
    nixosConfigurations = {
      portable = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./common.nix
          profile
        ];
      };
    };
  };
}
