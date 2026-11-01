{ config, lib, pkgs, ... }:

{
  home.username = "cata";
  home.homeDirectory = "/home/cata";

  home.stateVersion = "26.05";

  home.packages = [
    pkgs.fish
    pkgs.fishPlugins.done
    pkgs.fishPlugins.fzf-fish
    pkgs.fishPlugins.forgit
    pkgs.fishPlugins.colored-man-pages
    pkgs.fishPlugins.fifc
    pkgs.fishPlugins.grc
    pkgs.fishPlugins.z
    pkgs.fzf
    pkgs.grc
    pkgs.starship
    pkgs.fastfetch
    pkgs.libcanberra

    pkgs.kdePackages.qtsvg
    pkgs.kdePackages.kio
    pkgs.kdePackages.kio-fuse
    pkgs.kdePackages.kio-extras
    pkgs.kdePackages.kio-admin
    pkgs.kdePackages.dolphin-plugins

    pkgs.comfortaa

    pkgs.nix-diff
    pkgs.nix-tree
    (pkgs.agda.withPackages (p: [
      p.standard-library
    ]))

    pkgs.kdePackages.okular
    pkgs.kdePackages.ghostwriter
    pkgs.kdePackages.gwenview
    pkgs.kdePackages.kclock
    pkgs.kdePackages.partitionmanager
    pkgs.kdePackages.kdenlive
    pkgs.kdePackages.elisa
    pkgs.kdePackages.xdg-desktop-portal-kde

    pkgs.qalculate-qt
    pkgs.libreoffice-qt-stable
    pkgs.hunspell
    pkgs.hunspellDicts.en_US
    pkgs.hunspellDicts.ro_RO
    pkgs.hyphenDicts.en_US
    pkgs.hyphenDicts.ro_RO
    pkgs.haruna
    pkgs.vlc
    pkgs.mpv
    pkgs.rhythmbox
    pkgs.shortwave
    #pkgs.handbrake
    pkgs.ffmpeg
    pkgs.whatsie
    pkgs.pdf4qt
    pkgs.pdf2odt
    pkgs.pdf2svg
    pkgs.pdfarranger
    pkgs.qbittorrent-enhanced
    pkgs.xwayland
    pkgs.kshutdown
    pkgs.foliate
    pkgs.xournalpp
    pkgs.btop
    pkgs.gparted
    pkgs.geoclue2
    pkgs.CuboCore.corekeyboard
    pkgs.otpclient
    pkgs.exfatprogs

    pkgs.kdePackages.qtstyleplugin-kvantum
    pkgs.kdePackages.aurorae
    pkgs.kdePackages.oxygen
    pkgs.sweet-nova
    pkgs.colorfuldarkglobal6-kde
    pkgs.beauty-line-icon-theme
    pkgs.candy-icons
    pkgs.kde-rounded-corners
    #pkgs.sweet-kde

    pkgs.kdePackages.kontact
    pkgs.kdePackages.calendarsupport
    pkgs.kdePackages.kcalendarcore
    pkgs.kdePackages.libkdepim
    pkgs.kdePackages.kdepim-addons
    pkgs.kdePackages.kdepim-runtime
  ];

  nixpkgs.overlays = [
    (final: prev: {
      CuboCore.corekeyboard = prev.CuboCore.corekeyboard.overrideAttrs (old: {
        src = prev.fetchFromGitLab {
          owner = "raducu427";
          repo = "corekeyboard-sweet";
          tag = "v5.0.1";
          hash = "sha256-OWDFT8pkCmI0CVSfDo3aksymoyZnI1kvRP5F5QNvsyA=";
        };
      });
    })
    (final: prev: {
      colorfuldarkglobal6-kde = prev.colorfuldarkglobal6-kde.overrideAttrs (old: {
        installPhase = ''
          mkdir -p "$out/share/plasma/look-and-feel/Colorful-Splash-6"
          mkdir -p "$out/share/aurorae/themes"
          mkdir -p "$out/share/color-schemes"
          mkdir -p "$out/share/konsole"
          mkdir -p "$out/share/icons/Colorful-Dark-6"
          mkdir -p "$out/share/kvantum/Colorful-Dark-Kvantum"
          mkdir -p "$out/share/wallpapers"

          cp -rd "Colorful SplashScreen/Colorful-Splash-6"/* -t "$out/share/plasma/look-and-feel/Colorful-Splash-6/"


          cp -rd "Colorful Window Decorations/Colorful-Blur-Dark-Aurorae-6" -t "$out/share/aurorae/themes/"
          cp -rd "Colorful Window Decorations/Colorful-Dark-Aurorae-6" -t "$out/share/aurorae/themes/"
          cp -rd "Colorful Window Decorations/Colorful-Dark-Color-Aurorae-6" -t "$out/share/aurorae/themes/"

          cp -rd "Colorful Konsole Color Schemes"/* -t "$out/share/konsole"

          cp -rd "Colorful Color Schemes"/* -t "$out/share/color-schemes/"
          cp -rd "Colorful Icons Themes/Colorful-Dark-Icons" -t "$out/share/icons/"

          cp -rd "Colorful Kvantum Themes/Colorful-Dark-Kvantum" -t "$out/share/kvantum/Colorful-Dark-Kvantum/"

          cp -rd "Colorful Wallpapers"/* -t "$out/share/wallpapers"
        '';
      });
    })
  ];

  home.file = {
    #"/home/cata/.gtkrc-2.0".force = lib.mkForce true;
    #"/home/cata/.config/gtk-3.0/settings.ini".force = lib.mkForce true;
    #"/home/cata/.config/gtk-4.0/settings.ini".force = lib.mkForce true;
    #"/home/cata/.config/mozilla/firefox/Marius Raducan/search.json.mozlz4".force = lib.mkForce true;
  };

  #home.keyboard.layout = "ro,us";

  fonts.fontconfig.enable = true;

  imports = [
    ./starship.nix
    ./fastfetch.nix
  ];

  programs = {
    home-manager.enable = true;

    firefox = {
      enable = true;
      profiles."Marius Raducan" = {
        settings = {
          "browser.tabs.inTitlebar" = 0;
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.download.always_ask_before_handling_new_types" = true;
          "browser.translation.ui.show" = true;
          "browser.translations.enable" = true;
          "browser.translations.alwaysTranslateLanguages" = "ru,de,zh-Hans,zh-Hant,nl,fr,hi,ar,ja,it,es,pt";
          "sidebar.position_start" = false;
          "sidebar.revamp" = false;
        };
        search = {
          default = "ddg";
        };
        handlers = {
          mimeTypes = {
            "application/pdf" = {
              action = 2;
              ask = true;
              handlers = [
                {
                  name = "Firefox";
                  path = "${pkgs.firefox}/bin/firefox";
                }
              ];
              extensions = [ "pdf" ];
            };
          };
          schemes = {
            mailto = {
              action = 2;
              ask = true;
              handlers = [
                {
                  name = "app.tuta.com";
                  uriTemplate = "https://app.tuta.com/mailto#url=%s";
                }
              ];
            };
          };
        };
        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [

          ];
        };
      };
    };

    emacs = {
      enable = true;
      extraPackages =
        epkgs: with epkgs; [
          agda2-mode
          sweet-theme
        ];
      extraConfig = ''
        (load-theme 'sweet t)
      '';
    };

    kate = {
      enable = true;
      editor = {
        theme.name = "ayu Dark";
        brackets = {
          automaticallyAddClosing = true;
          highlightRangeBetween = true;
          highlightMatching = true;
          flashMatching = true;
        };
      };
      ui.colorScheme = "Sweet";
    };

    konsole = {
      enable = true;
      defaultProfile = "Sweet";
      profiles = {
        Sweet = {
          name = "Sweet";
          colorScheme = "Sweet";
          font = {
            name = "Hack";
            size = 10;
          };
        };
      };
    };
  };

  qt = {
    enable = true;
    kvantum = {
      enable = true;
      settings.General.theme = "Sweet-transparent-toolbar";
    };
  };

  /*gtk = {
    enable = true;
    theme = {
      name = "Sweet";
      package = pkgs.sweet;
    };
  };*/

  xdg = {
    autostart = {
      enable = true;
      entries = [
        "${pkgs.CuboCore.corekeyboard}/share/applications/cc.cubocore.CoreKeyboard.desktop"
        "${pkgs.whatsie}/share/applications/com.ktechpit.whatsie.desktop"
        "${pkgs.kdePackages.dolphin}/share/applications/org.kde.dolphin.desktop"
        "${pkgs.kdePackages.kate}/share/applications/org.kde.kate.desktop"
        "${pkgs.kdePackages.konsole}/share/applications/org.kde.konsole.desktop"
        "${pkgs.firefox}/share/applications/firefox.desktop"
      ];
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/mailto" = "firefox.desktop";
      };
    };
  };

  programs.plasma = {
    enable = true;

    session = {
      sessionRestore = {
        restoreOpenApplicationsOnLogin = "startWithEmptySession";
      };
    };

    input.keyboard = {
      numlockOnStartup = "on";
    };

    fonts = {
      general = {
        family = "Comfortaa";
        pointSize = 10;
      };
      fixedWidth = {
        family = "Hack";
        pointSize = 10;
      };
      small = {
        family = "Comfortaa";
        pointSize = 8;
      };
      toolbar = {
        family = "Comfortaa";
        pointSize = 10;
      };
      menu = {
        family = "Comfortaa";
        pointSize = 10;
      };
      windowTitle = {
        family = "Comfortaa";
        pointSize = 10;
      };
    };

    workspace = {
      clickItemTo = "open";
      #lookAndFeel = "${pkgs.sweet-nova}/share/plasma/look-and-feel/com.github.eliverlara.sweet";
      colorScheme = "Sweet";
      cursor = {
        theme = "Sweet-cursors";
        size = 24;
        cursorFeedback = "Blinking";
        taskManagerFeedback = true;
        animationTime = 5;
      };
      windowDecorations = {
          library =  "org.kde.kwin.aurorae";
          theme = "__aurorae__svg__Sweet-Dark-transparent";
      };
      widgetStyle = "kvantum-dark";
      theme = "Sweet";
      iconTheme = "BeautyLine";
      soundTheme = "ocean";
      #wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Kay/contents/images_dark/1080x1920.png";
      wallpaper = "${pkgs.colorfuldarkglobal6-kde}/share/wallpapers/Colorful-Circle Wallpaper With Plasma Logo.png";
      splashScreen.theme = "Colorful-Splash-6";
    };

    #Colorful-Circle Wallpaper With Plasma Logo.png
    #Colorful-Circle Wallpaper Without Logo.png
    #Colorful-Wallpaper-With Plasma Logo.png
    #Colorful-Wallpaper-With Plasma Logo2.png
    #Colorful-Wallpaper-Without Logo.png

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";
    };

    kscreenlocker = {
      autoLock = false;
      appearance = {
        alwaysShowClock = true;
        showMediaControls = true;
        wallpaper = "${pkgs.colorfuldarkglobal6-kde}/share/wallpapers/Colorful-Wallpaper-Without Logo.png";
      };
    };

    powerdevil = {
      AC = {
        powerButtonAction = "shutDown";
        autoSuspend = {
          action = "nothing";
          # idleTimeout = null;
        };
        whenSleepingEnter = "standby";
        whenLaptopLidClosed = "sleep";
        inhibitLidActionWhenExternalMonitorConnected = true;
        turnOffDisplay = {
          idleTimeout = "never";
          # idleTimeoutWhenLocked = 600;
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 900;
        };
      };
      battery = {
        powerButtonAction = "sleep";
        autoSuspend = {
          action = "sleep";
          idleTimeout = 900;
        };
        whenSleepingEnter = "standby";
        whenLaptopLidClosed = "sleep";
        inhibitLidActionWhenExternalMonitorConnected = true;
        turnOffDisplay = {
          idleTimeout = 600;
          idleTimeoutWhenLocked = 30;
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 300;
        };
      };
    };

    panels = [
      {
        location = "top";
        height = 32;
        alignment = "left";
        opacity = "translucent";
        widgets = [
          {
            kickerdash.icon = "${pkgs.beauty-line-icon-theme}/share/icons/BeautyLine/apps/scalable/distributor-logo-nixos.png";
          }
          {
            applicationTitleBar = {
              windowControlButtons = {
                iconSource = "aurorae";
                auroraeTheme = "Sweet-Dark";
                buttonsMargin = 8;
              };
              windowTitle = {
                hideEmptyTitle = true;
                undefinedWindowTitle = "NixOS";
              };
              layout = {
                spacingBetweenElements = 6;
                elements = [
                  "windowCloseButton"
                  "windowMaximizeButton"
                  "windowMinimizeButton"
                  "windowTitle"
                ];
              };
              behavior = {
                activeTaskSource = "activeTask";
                #disableForNotMaximized = true;
              };
            };
          }
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          {
            digitalClock = {
              time = {
                showSeconds = "onlyInTooltip";
                format = "24h";
              };
              date = {
                format = {
                  custom = "MMM d,";
                };
                position = "besideTime";
              };
              calendar = {
                plugins = [
                  #"alternatecalendar"
                  #"astronomicalevents"
                  "holidaysevents"
                  "pimevents"
                ];
              };
              font = {
                family = "Comfortaa";
                bold = true;
                size = 11;
              };
            };
          }
          "org.kde.plasma.panelspacer"
          {
            plasmaPanelColorizer = {
              general.hideWidget = true;
            };
          }
          {
            systemTray = {
              icons = {
                spacing = "medium";
                scaleToFit = true;
              };
              items = {
                hidden = [
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.cameraindicator"
                  "org.kde.plasma.manage-inputmethod"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.printmanager"
                  "org.kde.kscreen"
                  "org.kde.plasma.battery"
                  "org.kde.merkuro.contact.applet"
                ];
                shown = [
                  "org.kde.plasma.keyboardlayout"
                  "org.kde.plasma.keyboardindicator"
                  "org.kde.plasma.weather"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.mediacontroller"
                ];
                configs = {
                  keyboardLayout.displayStyle = "flag";
                  weather = {
                    placeDisplayName = "Bacau";
                    placeInfo = "Bacau|15150";
                    provider = "dwd";
                  };
                };
              };
            };
          }
          "org.kde.plasma.showdesktop"
        ];
      }
      {
        location = "bottom";
        height = 61;
        alignment = "center";
        lengthMode = "fit";
        hiding = "dodgewindows";
        opacity = "translucent";
        floating = true;
        widgets = [
          {
            iconTasks = {
              appearance.iconSpacing = "large";
              launchers = [
                "applications:org.kde.konsole.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:firefox.desktop"
                "applications:org.kde.kate.desktop"
                "applications:kshutdown.desktop"
                "applications:emacs.desktop"
              ];
            };
          }
        ];
      }
    ];

    shortcuts = {
      ksmserver = {
        "Lock Session" = [
          "Screensaver"
          "Meta+Ctrl+Alt+L"
        ];
      };

      kwin = {
        "Expose" = "Meta+,";
        "Switch Window Down" = "Meta+J";
        "Switch Window Left" = "Meta+H";
        "Switch Window Right" = "Meta+L";
        "Switch Window Up" = "Meta+K";
      };
    };

    kwin = {
      titlebarButtons.right = [
        #"keep-above-windows"
        #"more-window-actions"
        #"application-menu"
      ];

      titlebarButtons.left = [
        "close"
        "maximize"
        "minimize"
      ];

      effects = {
        blur = {
          enable = true;
          noiseStrength = 8;
          strength = 6;
        };

        slideBack.enable = true;

        translucency.enable = true;

        wobblyWindows.enable = true;

        minimization = {
          animation = "magiclamp";
          duration = 50;
        };

        cube.enable = true;

        dimInactive.enable = true;
        dimAdminMode.enable = true;

      };

      virtualDesktops = {
        rows = 1;
        number = 2;
      };

      borderlessMaximizedWindows = true;

      nightLight = {
        enable = true;
        mode = "automatic";
        temperature = {
          day = 4500;
          night = 3000;
        };
        transitionTime = 30;
      };

    };

    /*startup.startupScript."autostart" = {
      text = "corekeyboard --platform xcb &";
      priority = 4;
    };*/

    configFile = {
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = true;

      "kwinrc"."Round-Corners" = {
        "ActiveOutlineUseCustom" = false;
        "ActiveOutlineUsePalette" = true;
        "ActiveShadowUsePalette" = true;
        "InactiveOutlineThickness" = 2;
        "InactiveOutlineUseCustom" = false;
        "InactiveOutlineUsePalette" = true;
        "InactiveShadowUsePalette" = true;
        "OutlineThickness" = 2;
        "UseSquircleShape" = true;
      };

      "katerc"."KTextEditor Document" = {
        "Auto Save" = true;
        "Auto Save Interval" = 0;
        "Auto Save On Focus Out" = true;
      };

    };
  };

}

