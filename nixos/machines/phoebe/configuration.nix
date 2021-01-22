{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware.nix
      ./../../common/configuration.nix
    ];

  networking.hostName = "phoebe"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.interfaces.enp9s0f3u4u2.useDHCP = true;
  networking.interfaces.wlp5s0.useDHCP = true;

  services.xserver.videoDrivers = [ "nvidiaLegacy390" ];

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.leo = {
    isNormalUser = true;
    uid = 1000;
    hashedPassword = "$6$O7UljwalgpxiZZ$MBbQQtKcWLzPrxfuuZNhcz/RGKt707fAxkD70vfB.7Px4ILdplO0Y1Hc.yZ2Q1SGH6C6O/54Rb88Dk1Q8mXCj0";
    description = "Leonhard Markert";
    extraGroups = [ "docker" "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };
}

