{ config, lib, pkgs, ... }:
let
  #somtin
in
{
  imports =
  [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
  ];

  #home-manager.useGlobalPkgs = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Networking
  networking.hostName = "mogos";
  networking.wireless.enable = true;
  # Wireless
  networking.wireless.userControlled.enable = true;  

  # Time zone 
  time.timeZone = "Europe/Budapest";

  nixpkgs.config.allowUnfree = true; 

  # Getting graphical
  services = {
    greetd = { 
      enable = true;
      settings = {default_session = { command = "${pkgs.greetd.greetd}/bin/agreety --cmd startx";};};
    };
    xserver = {
      enable = true;
      displayManager.lightdm.enable = false;
      displayManager.startx.enable = true;
      enableTearFree = true; 
      xkb = {
        layout = "us,hu";
        options = "grp:alt_space_toggle";
      };
    };
  };

  users.users.regular = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "bredr";
        Experimental = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  # System wide software
  programs.firefox.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    docker
    rlaunch
    greetd.greetd
    blugon
    feh
    prismlauncher
    wpa_supplicant_gui
    flameshot
    discord
    gimp
    gh
    git
    bluez
    bluetui
    neofetch
    libreoffice-still
    heroic
    lutris
    qemu
  ];

  # System wide configuration
  environment.etc."issue".text = lib.mkForce ''
    [?25l[?7l[0m[34m[1m              ____       [0m[36m[1m_______        ____
    [0m[34m[1m             /####\      [0m[36m[1m\######\      /####\
    [0m[34m[1m             ######\      [0m[36m[1m\######\    /#####/
    [0m[34m[1m             \######\      [0m[36m[1m\######\  /#####/
    [0m[34m[1m              \######\      [0m[36m[1m\######\/#####/    [0m[34m[1m/\
    [0m[34m[1m               \######\      [0m[36m[1m\###########/    [0m[34m[1m/##\
    [0m[34m[1m        ________\######\______[0m[36m[1m\#########/    [0m[34m[1m/####\
    [0m[34m[1m       /#######################[0m[36m[1m\#######/    [0m[34m[1m/######
    [0m[34m[1m      /#########################[0m[36m[1m\######\   [0m[34m[1m/######/
    [0m[34m[1m     /###########################[0m[36m[1m\######\ [0m[34m[1m/######/
    [0m[34m[1m     ¯¯¯¯¯¯¯¯¯¯¯¯[0m[36m[1m/######/[0m[34m[1m¯¯¯¯¯¯¯¯¯[0m[36m[1m\######[0m[34m[1m/######/
    [0m[36m[1m                /######/           [0m[36m[1m\####[0m[34m[1m/######/________
    [0m[36m[1m  _____________/######/             [0m[36m[1m\##[0m[34m[1m/################\
    [0m[36m[1m /###################/               [0m[36m[1m\[0m[34m[1m/##################\
    [0m[36m[1m \##################/[0m[34m[1m\               /###################/
    [0m[36m[1m  \################/[0m[34m[1m##\             /######/¯¯¯¯¯¯¯¯¯¯¯¯¯
    [0m[36m[1m   ¯¯¯¯¯¯¯¯/######/[0m[34m[1m####\           /######/
    [0m[36m[1m          /######/[0m[34m[1m######\[0m[36m[1m_________[0m[34m[1m/######/[0m[36m[1m____________
    [0m[36m[1m         /######/ [0m[34m[1m\######\[0m[36m[1m###########################/
    [0m[36m[1m        /######/   [0m[34m[1m\######\[0m[36m[1m#########################/
    [0m[36m[1m        ######/    [0m[34m[1m/#######\[0m[36m[1m#######################/
    [0m[36m[1m        \####/    [0m[34m[1m/#########\[0m[36m[1m¯¯¯¯¯¯\######\¯¯¯¯¯¯¯¯
    [0m[36m[1m         \##/    [0m[34m[1m/###########\[0m[36m[1m      \######\
    [0m[36m[1m          \/    [0m[34m[1m/#####/\######\[0m[36m[1m      \######\
    [0m[34m[1m               [0m[34m[1m/#####/  \######\[0m[36m[1m      \######\
    [0m[34m[1m              [0m[34m[1m/#####/    \######\[0m[36m[1m      \######
    [0m[34m[1m              [0m[34m[1m\####/      \######\[0m[36m[1m      \####/
    [0m[34m[1m               [0m[34m[1m¯¯¯¯        ¯¯¯¯¯¯¯[0m[36m[1m       ¯¯¯¯[0m
    [1;32m<<< This is \n.\o, running \S on a \s kernel, version \r >>>[0m
  '';

  # Vim is king
  programs = {
    vim.enable = true;
    vim.defaultEditor = true;
    nano.enable = false;
  };

  # Graphics drivers
  nixpkgs.config.packageOverrides = pkgs: {
      intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware.graphics = { # hardware.graphics since NixOS 24.11
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver

  nixpkgs.config.permittedInsecurePackages = [ "electron-33.4.11" ];

  system.stateVersion = "24.11"; # Did you read the comment?
}

