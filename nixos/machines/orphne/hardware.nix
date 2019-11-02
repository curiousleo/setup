# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/66ccdb60-350f-4b11-a650-81635a8c7b18";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D162-433C";
    fsType = "vfat";
  };

  # boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/aa3ccf7b-2086-435b-a2cb-cb447dd458bd";
  boot.initrd.luks.devices = {
    cryptkey = {
      device = "/dev/disk/by-uuid/b5077d50-2daf-49b1-945d-eb9bf888e61c";
    };

    cryptroot = {
      device = "/dev/disk/by-uuid/aa3ccf7b-2086-435b-a2cb-cb447dd458bd";
      keyFile = "/dev/mapper/cryptkey";
    };

    cryptswap = {
      device = "/dev/disk/by-uuid/879d73f6-5f65-4a2f-a75b-240b8dc902c6";
      keyFile = "/dev/mapper/cryptkey";
    };
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/dd16fbe0-3f15-4814-bae5-064ebec31f02"; }];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # High-DPI console
  i18n.consoleFont =
    lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
}
