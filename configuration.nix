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
    [1;32m<<< Welcome to NixOs 24.11.718112.72841a4a8761 (\m) - \l >>>[0m\n
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

