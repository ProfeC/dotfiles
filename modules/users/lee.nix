{ config, lib, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’ if needed.
  users.users.lee = {
    isNormalUser = true;
    description = "Lee";
    extraGroups = [ "networkmanager" "wheel" ];

    # This makes sure you always have Kate installed, but you can add more here.
    packages = with pkgs; [
      kdePackages.kate
    ];

    # Set the initial password.
    initialHashedPassword = "$y$j9T$Z7Pj5n6.NBWyHi6HXLrsa.$eYLHZC7pUE/bnHcz96z1RqiaWgif41Aa57wgvjzVAc2";
  };
}
