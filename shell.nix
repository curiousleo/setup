{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell { buildInputs = with pkgs; [ nixpkgs-fmt shfmt stow ]; }
