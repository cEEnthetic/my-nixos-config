{ pkgs, lib, ... }:
{
  services.syncthing = {
    enable = true;
#    key = "/home/regular/.local/share/ssl/key.pem";
#    cert = "/home/regular/.local/share/ssl/cert.pem";
    settings = {
      devices = {
        "sugom" = { id = "7T2CMRK-63RRVAM-JBC7Y22-3FCLGAW-MVKIWWM-QUR5XPN-DWVYY3T-UP3DEQ6"; };
      };
      folders = {
        "msctmp" = {
          path = "/home/regular/Music/msctmp";
          devices = [ "sugom" ];
        };
      };
    };
  };
}
