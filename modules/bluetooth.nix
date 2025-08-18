{ config, pkgs, ... }:

{
  # Enable Bluetooth
  hardware.bluetooth.enable = true;
#   hardware.bluetooth.settings = {
#     General = {
#       Enable = "Source,Sink,Media,Socket";
#         Experimental = true;
#     }
#   }

}