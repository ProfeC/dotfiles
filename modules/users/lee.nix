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
    initialHashedPassword = "";
  };
}
