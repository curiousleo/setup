# cachix

Unfortunately, `cachix use` assumes a particular file layout so it won't work with the symlink structure used here.

So instead of calling `cachix use xyz`, go to https://xyz.cachix.org and copy the public key from there. Then copy one of the existing files in this directory and fill in the Cachix repo URL and public key.
