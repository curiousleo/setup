{ pkgs, ... }:
{
  environment.variables = { EDITOR = "vim"; };
  environment.systemPackages = with pkgs; [
    (
      neovim.override {
        vimAlias = true;
        withPython = true;
        configure = {
          customRC = builtins.readFile ./vimrc;
          packages.myNeovimPackage = with pkgs.vimPlugins; {
            start = [ vim-nix vim-fugitive fzf-vim ];
            opt = [];
          };
        };
      }
    )
  ];
}
