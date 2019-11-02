# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/62c1b7c3-8a37-4631-8f63-4ed10300473e";
      fsType = "ext4";
    };

  #boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/32b1a8ab-6bd4-427b-9a66-38da01a95bd4";
  boot.initrd.luks.devices =
    {  cryptkey = { device = "/dev/disk/by-uuid/9af91083-0e16-43d2-87aa-a1e0c110cdb5"; };
       cryptroot =
       { device = "/dev/disk/by-uuid/32b1a8ab-6bd4-427b-9a66-38da01a95bd4";
         keyFile = "/dev/mapper/cryptkey";
       };
       cryptswap =
       { device = "/dev/disk/by-uuid/bbfd5daa-532b-4302-b8df-1857ea525bb7";
         keyFile = "/dev/mapper/cryptkey";
       };
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E3FE-73B7";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/cf437b23-7b01-4ba5-9ac9-08e2a0763dce"; }
    ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
