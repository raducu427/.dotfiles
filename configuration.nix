# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "15:45" ];
  #nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Enablebluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  # Unfix FOD (fix output derivation)
  #nix.settings.sandbox = "relaxed";

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  #i18n.extraLocales = [ "en_US.UTF-8/UTF-8" ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  services.libinput.mouse.accelProfile = "flat";

  services.davfs2.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager = {
    #plasma-login-manager.enable = true;
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      #theme = "Colorful-SDDM";
      extraPackages = [
        pkgs.sddm-astronaut
        pkgs.kdePackages.qtmultimedia
        pkgs.colorfuldarkglobal6-kde
      ];
    };
  };

  services.desktopManager.plasma6.enable = true;

  services.geoclue2 = {
    enable = true;
    enable3G = true;
    enableCDMA = true;
    enableModemGPS = true;
    enableNmea = true;
    enableWifi = true;
    submitData = true;
  };

  services.displayManager = {
	autoLogin.enable = true;
	autoLogin.user = "cata";
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ro,us";
    variant = "std,";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  security.pam.services."cata".kwallet.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."cata" = {
    isNormalUser = true;
    description = "cata";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.kontact
      kdePackages.kmail
      kdePackages.kmail-account-wizard
      kdePackages.merkuro
      kdePackages.akonadi
      kdePackages.akonadi-calendar
      kdePackages.akonadi-import-wizard
      kdePackages.akonadi-search
      kdePackages.akonadi-contacts
      kdePackages.akonadiconsole
      kdePackages.korganizer
      kdePackages.kcontacts
      kdePackages.calendarsupport
      kdePackages.kcalendarcore
      kdePackages.libkdepim
      kdePackages.kdepim-addons
      kdePackages.kdepim-runtime
      libsForQt5.qtpim
    ];
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = [
      "/home/cata/.ssh/id_ed25519"
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    secrets.webdav = {
      sopsFile = ./secrets.yaml;
      mode = "0600";
      path = "/etc/davfs2/secrets";
    };
  };

  fileSystems = {
    "/mnt/Storage" = {
      device = "https://u702228.your-storagebox.de";
      fsType = "davfs";
      options = [
        "uid=cata"
        "gid=users"
        "mode=777"
        "x-systemd.automount"
        "noauto"
      ];
    };
    "/mnt/hdd" = {
      device = "/dev/disk/by-uuid/8cacdf6f-3461-48f1-8a8c-c80556923914";
      fsType = "ext4";
      options = [
        "defaults"
      ];
    };
    "/mnt/nvme" = {
      device = "/dev/disk/by-uuid/6b835595-559d-48dd-b707-a8f3e65c3b4c";
      fsType = "ext4";
      options = [
        "defaults"
      ];
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  programs.git.enable = true;

  programs.partition-manager.enable = true;


  # Enable KDE PIM suite, which includes applications like KMail and Kontact.
  programs.kde-pim = {
    enable = true;
    kmail = true;
    kontact = true;
    merkuro = true;
  };

  /*programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -g fish_key_bindings fish_vi_key_bindings
      set -g fish_cursor_default block blink
      starship init fish | source
      fastfetch
    '';
  };

  #users.users.cata.shell = pkgs.fish;
  users.defaultUserShell = pkgs.fish;*/

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget
     git
     davfs2
     sops
     ssh-to-age
     kdePackages.plasma-login-manager
     sddm-astronaut
     sound-theme-freedesktop
     pavucontrol
     alsa-utils
     util-linux
     usbutils
     ubase
     toybox
     busybox
     cyme
     lshw
     lshw-gui
  ];

  nixpkgs.overlays = [
    (final: prev: {
      sddm-astronaut = prev.sddm-astronaut.override {
        embeddedTheme = "cyberpunk";
      };
    })
    (final: prev: {
      colorfuldarkglobal6-kde = prev.colorfuldarkglobal6-kde.overrideAttrs (old: {
        installPhase = ''
          mkdir -p "$out/share/sddm/themes"
          mkdir -p "$out/share/wallpapers"
          cp -rd "Colorful SDDM Themes/Colorful-SDDM" -t "$out/share/sddm/themes"
          cp -rd "Colorful Wallpapers"/* -t "$out/share/wallpapers"
        '';
      });
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
