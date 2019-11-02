NixOS machine setup
===================

.. code-block:: shell

  $ sudo ln -s $(readlink -f machines/${HOSTNAME}/configuration.nix) /etc/nixos/configuration.nix
