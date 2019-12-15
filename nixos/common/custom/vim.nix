with import <nixpkgs> {};

let
  customPlugins = {
    ghcid = pkgs.vimUtils.buildVimPlugin {
      name = "ghcid";
      src = (
        pkgs.fetchFromGitHub {
          owner = "ndmitchell";
          repo = "ghcid";
          rev = "08dff021a806c252d8eeccf44fa30e8d4118b137"; # version 0.7.5
          sha256 = "05w4lqqs25m10rpjglkm1ggyssl9kig0nbd0qkg0l38zhc87afjr";
        }
      ) + "/plugins/nvim";
    };
  };
in
neovim.override {
  vimAlias = true;
  withPython = true;
  configure = {
    customRC = builtins.readFile ./vimrc;
    packages.myNeovimPackage = with pkgs.vimPlugins // customPlugins; {
      start = [ ghcid vim-nix vim-lsc ];
      opt = [];
    };
  };
}
