# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
let
  masterPkgs = import ./custom/master.nix;
in
{
  imports = [
    ./cachix.nix
    ./custom/vim.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Enable virtualisation.
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  boot.kernel.sysctl = {
    # For IntelliJ https://confluence.jetbrains.com/x/ioCJAQ.
    "fs.inotify.max_user_watches" = 1048576;
  };

  # Enable NTFS support (generally, not just for booting).
  boot.supportedFilesystems = [ "ntfs" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable NetworkManager.
  networking.networkmanager.enable = true;

  # Enable Wireguard.
  networking.wireguard.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Console settings.
  console = {
    font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  # Fonts.
  fonts.fonts = with pkgs; [
    noto-fonts
    fira-code
  ];

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    linuxPackages.cpupower
    linuxPackages.perf
    # graphical programs
    alacritty
    chromium
    emacs
    firefox
    gimp
    gnome3.gnome-boxes
    gnome3.gnome-tweak-tool
    gnomeExtensions.paperwm
    # The Bazel plugin tends not to be up to date with the latest IntelliJ
    # version [1]. Use a compatible version of "Linux without JBR" [2].
    # [1] https://plugins.jetbrains.com/plugin/8609-bazel
    # [2] https://www.jetbrains.com/idea/download/other.html
    masterPkgs.jetbrains.idea-community
    libreoffice
    meld
    mumble
    shotwell
    syncthing
    thunderbird
    transmission-gtk
    virtmanager
    vscode
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
    git-lfs
    gitAndTools.git-crypt
    gitAndTools.git-imerge
    gnumake
    gnupg
    google-cloud-sdk
    graphviz
    htop
    hunspell
    hunspellDicts.de-de
    hunspellDicts.en-gb-ise
    hunspellDicts.en-us-large
    hunspellDicts.fr-moderne
    imagemagick
    j
    jq
    kubectl
    magic-wormhole
    minikube
    nix-prefetch-git
    #nuspell
    ocrmypdf
    opam
    podman
    proselint
    python3
    restic
    ripgrep
    rr
    socat
    stack
    starship
    stow
    tig
    tmux
    tree
    vale
    vis
    watson
    wget
    zoxide
  ];

  # Use nix-index to find packages for missing commands
  programs.command-not-found.enable = false;
  programs.bash.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.sysdig.enable = true;
  programs.wireshark.enable = true;

  # List services that you want to enable:
  services.resolved = {
    enable = true;
  };

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

  # Enable U2F (for YubiKey) -- required in 20.03, no longer present in 20.09
  #hardware.u2f.enable = true;

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
  virtualisation.libvirtd.enable = true;
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
