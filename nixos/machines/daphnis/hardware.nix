# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

let
  uuids = {
    boot = "F1EA-B0D9";
    cryptkey = "a05482e7-30a9-41d0-bd9d-6444b69fe7c6";
    cryptrootEncrypted = "958e1c02-4e17-4353-a870-2efc8ff39b46";
    cryptrootDecrypted = "cac51875-fd84-4c0b-84ee-2ea4ba424569";
    cryptswapEncrypted = "390f1dc2-c6f8-4403-ae05-f758fc13d630";
    cryptswapDecrypted = "a95418c3-d52f-4dc6-b98c-3e4b72e181b4";
  };
in
{
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "nvme" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];

  boot.initrd.luks.devices = {
    cryptkey = {
      device = "/dev/disk/by-uuid/${uuids.cryptkey}";
    };

    cryptroot = {
      device = "/dev/disk/by-uuid/${uuids.cryptrootEncrypted}";
      keyFile = "/dev/mapper/cryptkey";
    };

    cryptswap = {
      device = "/dev/disk/by-uuid/${uuids.cryptswapEncrypted}";
      keyFile = "/dev/mapper/cryptkey";
    };
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/${uuids.cryptrootDecrypted}";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/${uuids.boot}";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/${uuids.cryptswapDecrypted}"; } ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # High-DPI console
  i18n.consoleFont =
    lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
}
