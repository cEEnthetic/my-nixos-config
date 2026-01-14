{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    sxhkd
    bspwm
    xorg.xinit
  ];

  home.file = 
  { 
    ".xinitrc" = {
      text = ''
        sxhkd &
        bspwm
      '';
      executable = true;
    };
    ".Xresources" = {
      text = ''
        XTerm*faceName: Monospace
        XTerm*faceSize: 12
        ! special
        *.foreground:   #586e75
        *.background:   #fdf6e3
        *.cursorColor:  #586e75

        ! black
        *.color0:       #002b36
        *.color8:       #657b83

        ! red
        *.color1:       #dc322f
        *.color9:       #dc322f

        ! green
        *.color2:       #859900
        *.color10:      #859900

        ! yellow
        *.color3:       #b58900
        *.color11:      #b58900

        ! blue
        *.color4:       #268bd2
        *.color12:      #268bd2

        ! magenta
        *.color5:       #6c71c4
        *.color13:      #6c71c4

        ! cyan
        *.color6:       #2aa198
        *.color14:      #2aa198

        ! white
        *.color7:       #93a1a1
        *.color15:      #000000
      '';
    };
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
