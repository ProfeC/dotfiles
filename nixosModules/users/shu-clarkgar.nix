{
  config,
  lib,
  pkgs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’ if needed.
  users.users.clarkgar = {
    isNormalUser = true;
    description = "G. L. Clark, II";
    extraGroups = ["networkmanager" "wheel"];
    hashedPasswordFile ="/run/secrets/pw-clarkgar";
    # openssh.authorizedKeys.keys = [];

    # This makes sure you always have Kate installed, but you can add more here.
    packages = with pkgs; [
      kdePackages.kate
    ];

    # Set the initial password.
    initialHashedPassword = "";
  };
}
