{ pkgs, lib, ... }:
let
  # interesting
in
{
  home.packages = with pkgs; [
    #comfortaa
    #cantarell-fonts
    route159
  ];
  fonts.fontconfig.enable = true;
}
