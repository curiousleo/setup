{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware.nix
      ./../../common/configuration.nix
    ];
  networking.hostName = "daphnis";
}
