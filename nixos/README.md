# NixOS machine setup

```console
$ sudo ln -s $(readlink -f machines/${HOSTNAME}/configuration.nix) /etc/nixos/configuration.nix
```
