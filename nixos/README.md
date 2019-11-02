# NixOS machine setup

```console
$ cp /etc/nixos/hardware-configuration.nix machines/${HOSTNAME}/hardware.nix
$ cp /etc/nixos/configuration.nix machines/${HOSTNAME}/configuration.nix
# Integrate machines/${HOSTNAME}/configuration.nix into this repo
$ sudo mv /etc/nixos/hardware-configuration.nix{,.bak}
$ sudo mv /etc/nixos/configuration.nix{,.bak}
$ sudo ln -s $(readlink -f machines/${HOSTNAME}/configuration.nix) /etc/nixos/configuration.nix
```
