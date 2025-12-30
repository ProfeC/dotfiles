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
    extraGroups = ["networkmanager" "wheel" "games"];
    hashedPasswordFile ="/home/lee/etc/nixos/secrets/pw-lee";
    shell = pkgs.zsh;
  };
}
