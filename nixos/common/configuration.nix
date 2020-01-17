# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  # all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in
{
  imports = [
    # Include the results of the hardware scan.
    ./cachix.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Enable virtualisation.
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  # Enable NTFS support (generally, not just for booting).
  boot.supportedFilesystems = [ "ntfs" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable NetworkManager.
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "latarcyrheb-sun32";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    linuxPackages.perf
    (import ./custom/vim.nix)
    # (all-hies.selection { selector = p: { inherit (p) ghc843 ghc863 ghc864 ghc865; }; })
    # graphical programs
    alacritty
    chromium
    emacs
    firefox
    gimp
    gnome3.gnome-boxes
    libreoffice
    meld
    syncthing
    transmission-gtk
    virtmanager
    zoom-us
    zotero
    # command line programs
    bat
    broot
    cabal-install
    cabal2nix
    cachix
    curl
    direnv
    dstat
    entr
    fd
    file
    fzf
    git
    gitAndTools.git-crypt
    gitAndTools.git-imerge
    git-lfs
    gnumake
    gnupg
    htop
    hunspell
    hunspellDicts.de-de
    hunspellDicts.en-gb-ise
    hunspellDicts.en-us-large
    hunspellDicts.fr-moderne
    imagemagick
    jq
    magic-wormhole
    nix-prefetch-git
    #nuspell
    opam
    proselint
    python3
    restic
    ripgrep
    rr
    socat
    stack
    stow
    tig
    tmux
    tree
    vale
    vis
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.sysdig.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable Flatpak.
  services.flatpak.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Use lorri (nix-shell replacement daemon).
  services.lorri.enable = true;

  # Install DBus packages required for GNOME. See https://nixos.wiki/wiki/Gnome
  services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf ];

  # Firmware update DBus service
  # Run fwupdmgr refresh && fwupdmgr get-updates && fwupdmgr update every now and then!
  services.fwupd.enable = true;

  # Enable TeamViewer.
  services.teamviewer.enable = true;

  # Enable PowerTop.
  powerManagement.powertop.enable = true;

  # Enable Bluetooth.
  hardware.bluetooth.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull; # required for bluetooth
  hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];

  # Enable U2F (for YubiKey).
  hardware.u2f.enable = true;

  # Enable Intel microcode updates
  # TODO: this should probably go into a "common hardware configuration for
  # Intel machines" file
  hardware.cpu.intel.updateMicrocode = true;

  services.xserver = {
    enable = true;
    autorun = true;

    layout = "us";
    xkbVariant = "altgr-intl";

    # Enable touchpad support.
    libinput.enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;
    desktopManager.gnome3.enable = true;

    #monitorSection = ''
    #  DisplaySize 406 228
    #'';
  };

  nix.extraOptions = "keep-outputs = true";
  nix.trustedUsers = [ "@wheel" ];

  #systemd.services.haskell-language-server = {
  #  enable = true;
  #  description = "Haskell Language Server";
  #  serviceConfig = {
  #    Type = "forking";
  #    ExecStart = "${pkgs.hie}/bin/hie start ...";
  #    ExecStop = "...";
  #    Restart = "on-failure";
  #  };
  #  wantedBy = [ "default.target" ];
  #};

  virtualisation.docker.enable = true;
  #virtualisation.libvirtd.enable = true;
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
