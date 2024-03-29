{ pkgs, ... }:
{
  environment.variables = { EDITOR = "vim"; };
  environment.systemPackages = with pkgs; [
    (
      neovim.override {
        vimAlias = true;
        withPython3 = true;
        configure = {
          customRC = builtins.readFile ./vimrc;
          packages.myNeovimPackage = with pkgs.vimPlugins; {
            start = [
              ayu-vim
              dhall-vim
              fzf-vim
              haskell-vim
              vim-fugitive
              vim-nix
              zig-vim
            ];
            opt = [];
          };
        };
      }
    )
  ];
}
