{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    git-lfs
  ];
}
