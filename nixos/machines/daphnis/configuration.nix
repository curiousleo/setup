{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix
    ./../../common/configuration.nix
  ];

  networking.hostName = "daphnis";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;

  users.mutableUsers = false;
  users.users.leo = {
    isNormalUser = true;
    uid = 1000;
    hashedPassword =
      "$6$94Wu55R5Q43jD9pr$0irVyqzunfaQaZKDTb21P9sQggNkQhpkaJ/QsoKVKuno3MnzFmN5XbBiHUCEAQhUdvTnusBEY/1LINNImyc860";
    description = "Leonhard Markert";
    extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "vboxusers" "wireshark" ];
  };

  nix.buildMachines = [
    {
      hostName = "build01.tweag.io";
      maxJobs = 24;
      sshUser = "nix";
      sshKey = "/root/.ssh/id-tweag-builder";
      system = "x86_64-linux";
      supportedFeatures = [ "benchmark" "big-parallel" "kvm" ];
    }
  ];

  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
}
