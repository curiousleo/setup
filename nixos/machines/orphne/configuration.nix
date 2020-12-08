{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix
    ./../../common/configuration.nix
  ];

  networking.hostName = "orphne";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  users.mutableUsers = false;
  users.users.leo = {
    isNormalUser = true;
    uid = 1000;
    hashedPassword =
      "$6$gbBlLam8Xck$12yL09PIVUkpQLpBz7JpbWDHsEb85T5D94Sot2aPRy/e3CV2B5KI0UbFq3P4Xgn2iHRQoORX/zYdVZlzhLXB1/";
    description = "Leonhard Markert";
    extraGroups = [ "docker" "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  services.restic.backups = {
    trail = {
      paths = [ "/home/leo/Trail" ];
      repository = "s3:https://s3.eu-central-1.wasabisys.com/leo-orphne-restic/trail";
      passwordFile = builtins.toString ../../../secret/orphne-restic-trail-password;
      s3CredentialsFile = builtins.toString ../../../secret/orphne-restic-trail-credentials;
    };
  };
}
