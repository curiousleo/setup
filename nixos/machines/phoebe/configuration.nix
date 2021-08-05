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

  # GeForce GT 710: out of nvidiaLegacy390, nvidia and nouveau, nouveau works best.
  #
  # $ nix-shell -p pciutils --run 'lspci -k | grep -A 2 -E "(VGA|3D)"'
  # 07:00.0 VGA compatible controller: NVIDIA Corporation GK208B [GeForce GT 710] (rev a1)
  #         Subsystem: NVIDIA Corporation Device 118b
  #         Kernel driver in use: nouveau
  #
  # https://nouveau.freedesktop.org/CodeNames.html lists GK208B as NV106 /
  # GeForce GT 720 under the NVE0 family (Kepler).
  #services.xserver.videoDrivers = [ "nouveau" ];

  # GeForce GTX 1650 Super: nouveau does not work; nvidia works.
  #
  # Careful: specifiying "nvidia" here is not enough! The following is also
  # required (in hardware.nix):
  #
  # boot.blacklistedKernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl.driSupport32Bit = true;
  virtualisation.docker.enableNvidia = true;

  # https://github.com/NixOS/nixpkgs/pull/118341#issuecomment-812629390
  # https://github.com/NVIDIA/nvidia-docker/issues/1447#issuecomment-801479573
  boot.kernelParams = [ "systemd.unified_cgroup_hierarchy=0" ];

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

