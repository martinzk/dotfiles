# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./config/zsh.nix
      ./config/i3status.nix
      # ./config/dunstrc.nix
      # ./config/battery-notifications.nix
    ];

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true; # 32Bit audio
  };

  # enable firewall open ports instead
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
        # videostream
        5556
        5558
    ];
  };
  boot.hardwareScan = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = ''
  options snd_hda_intel enable=1 index=1
  options snd_hda_intel enable=0 index=0
  '';

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreeRedistributable = true;
  };

  # Network
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.

  # Fonts
  fonts = {
        enableCoreFonts = true;
        enableFontDir = true;
        enableGhostscriptFonts = true;
        fonts = with pkgs; [
        corefonts
        source-code-pro
        unifont
        dejavu_fonts
        font-droid
    ];
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "source-code-pro";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # List services that you want to enable:
  hardware.opengl.driSupport32Bit = true;

  # Enable gnome3 for dbus
  services.gnome3.at-spi2-core.enable = true;

  # Enable battery services.
  # powerManagement.enable = true;
  # services.tlp.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
  };
  services.samba = {
  enable = true;
  };

  # Locate
  services.locate = {
  enable = true;
  interval = "09:00";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us, dk";
  services.xserver.xkbOptions = "eurosign:e, ctrl:nocaps, grp:alt_shift_toggle";

  systemd.user.services."xcape" = {
    enable = true;
    description = "xcape to use CTRL as ESC when pressed alone";
    wantedBy = [ "default.target" ];
    serviceConfig.Type = "forking";
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 2;
    serviceConfig.ExecStart = "${pkgs.xcape}/bin/xcape";
  };

  # systemd.user.services.xfce4-power-manager = {
  #   enable = true;
  #   description = "";
  #   wantedBy = [ "default.target" ];
  #   serviceConfig.Type = "forking";
  #   serviceConfig.Restart = "always";
  #   serviceConfig.RestartSec = 2;
  #   serviceConfig.ExecStart = "${system.config.path}/xfce4-power-manager";
  # };

  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.default = "i3";
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.default = "xfce";
  # services.xserver.displayManager.sessionCommands = "${pkgs.networkmanagerapplet}/bin/nm-applet & feh --bg-scale /home/martin/lol.jpg &";

  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  services.unclutter = {
    enable = true;
  };
  # services.acpid = {
  #   enable = true;
  # };

 services.udisks2.enable = true;

  services.redshift = {
    enable=true;
    latitude="57.048820";
    longitude="9.921747";
  };

  # zsh
  programs.zsh = {
    enable=true;
    shellInit = "
    # Set GTK_PATH so that GTK+ can find the Xfce theme engine.
    export GTK_PATH=${pkgs.xfce.gtk_xfce_engine}/lib/gtk-2.0

    # Set GTK_DATA_PREFIX so that GTK+ can find the Xfce themes.
    export GTK_DATA_PREFIX=${config.system.path}

    # Set GIO_EXTRA_MODULES so that gvfs works.
    export GIO_EXTRA_MODULES=${pkgs.xfce.gvfs}/lib/gio/modules

    # Launch xfce plugins
    xfsettingsd & # xfce settings
    xfce4-power-manager &
    xfce4-volumed & # Display sound volume notification
    xfce4-clipman &

    # NetworkManager
    nm-applet &
    ";
  };
  # pathsToLink =
  #     [ "/share/xfce4" "/share/themes" "/share/mime" "/share/desktop-directories"];
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  services.compton = {
  enable = true;
  };

  environment.systemPackages = with pkgs; [
                                            # Desktop
                                            # i3status
                                            # dmenu
                                            xorg.xbacklight
                                            gtk
                                            qt5.qtbase
                                            nix-repl
                                            coreutils

                                            # Theming
                                            hicolor_icon_theme
                                            paper-icon-theme
                                            arc-theme

                                            # System Tools
                                            xcape
                                            fasd
                                            acpi
                                            psmisc # killall
                                            shared_mime_info
                                            kde5.krunner

                                            # XFCE Tools
                                            xfce.xfce4_pulseaudio_plugin gstreamer # missing dependency
                                            xfce.xfce4_clipman_plugin
                                            xfce.xfce4taskmanager

                                            # Browser
                                            google-chrome

                                            # Shell
                                            zsh-prezto
                                            rxvt_unicode-with-plugins

                                            # Project
                                            gnumake
                                            texlive.combined.scheme-full
                                            gitAndTools.gitFull

                                            # Emacs
                                            emacs25
                                            python
                                            python27Packages.setuptools
                                            python27Packages.pip
                                            python27Packages.ipython
                                            aspell
                                            aspellDicts.en

                                            # Torrents
                                            transmission_gtk

                                            # Archiving
                                            zip
                                            unzip
                                            unrar

                                            # Media
                                            vlc
                                            calibre
                                            gimp
                                            zathura
                                            spotify
                                            arandr
                                            pavucontrol
                                            libreoffice
                                          ];
    nixpkgs.config.packageOverrides = pkgs: with pkgs; rec {
      emacs = pkgs.emacs25.overrideDerivation (args: rec {
        withGTK3 = true;
        withGTK2 = false;
        pythonPath = [];
        buildInputs = with pkgs; (args.buildInputs ++
        [
          makeWrapper
          python27
          python27Packages.setuptools
          python27Packages.pip
          python27Packages.ipython
        ]);

        postInstall = with pkgs.python27Packages; (args.postInstall + ''
        echo "This is PYTHONPATH: " $PYTHONPATH
        wrapProgram $out/bin/emacs \
        --prefix PYTHONPATH : "$(toPythonPath ${python}):$(toPythonPath ${ipython}):$(toPythonPath ${setuptools}):$(toPythonPath ${pip})";
        '');
      });
      # zsh-prezto fork
      zsh-prezto = pkgs.zsh-prezto.overrideDerivation (oldAttrs: {
        src = fetchgit {
          url = "https://github.com/chauncey-garrett/zsh-prezto";
          sha256 = "1337l9fcbl6kgjwsdjf3yw6phr5bhl9ir5hmxhsxyrmp359x567j";
        };
      });
      xfce4 = pkgs.xfce4.overrideDerivation (oldAttrs: {
      ver_maj = "0.3";
      });
    };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";
}
