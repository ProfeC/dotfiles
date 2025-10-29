{
  config,
  lib,
  pkgs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’ if needed.
  users.users.lee = {
    isNormalUser = true;
    description = "Lee";
    extraGroups = ["networkmanager" "wheel"];
    initialHashedPassword = ""; # Set the initial password.
    shell = pkgs.zsh;
  };
}
