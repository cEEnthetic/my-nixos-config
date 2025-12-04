{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    sxhkd
    bspwm
    xorg.xinit
  ];

  home.file.".xinitrc" = {
    text = ''
      sxhkd &
      bspwm
    '';
    executable = true;
  };

  #should probly move in a separate config, not sure
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = "vim.desktop";
        "text/html" = "firefox.desktop";
        "text/xml" = "firefox.desktop";
        "image/png" = "feh.desktop";
      };
    };
    desktopEntries = {
      vim = {
        name = "vim";
        exec = "${pkgs.vim}/bin/vim";
      };
      feh = {
        name = "feh";
        exec = "${pkgs.feh}/bin/feh -d";
      };
      firefox = {
        name = "firefox";
        exec = "${pkgs.firefox}/bin/firefox %U";
      };
    };
  };
}
