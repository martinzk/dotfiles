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
    ];

  hardware = {
    enableAllFirmware = true;
    pulseaudio.enable = true;
    pulseaudio.support32Bit = true; # 32Bit audio
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
  services.acpid.enable = true;
  powerManagement.enable = true;
  services.tlp.enable = true;

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

  # Locate
  services.locate.enable = true;

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

  services.xserver.windowManager.i3.enable = true;
  services.xserver.displayManager.sessionCommands = "${pkgs.networkmanagerapplet}/bin/nm-applet &";

  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  services.unclutter = {
    enable = true;
  };

  services.udisks2.enable = true;

  services.redshift = {
    enable=true;
    latitude="57.048820";
    longitude="9.921747";
  };

  # zsh
  programs.zsh = {
    enable=true;
    shellInit = "export XDG_DATA_HOME=$HOME/.local/share";
  };
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  environment.systemPackages = with pkgs; [
                                            # Desktop
                                            i3status
                                            dmenu
                                            xorg.xbacklight
                                            gtk
                                            qt5.qtbase

                                            # System Tools
                                            xcape
                                            fasd
                                            acpi

                                            # Browser
                                            google-chrome

                                            # Shell
                                            zsh-prezto
                                            rxvt_unicode-with-plugins

                                            # Project
                                            gnumake
                                            texlive.combined.scheme-full
                                            git

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

                                            # Media
                                            vlc
                                            calibre
                                            gimp
                                            zathura
                                            spotify
                                            arandr
                                            pavucontrol
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
    };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";
}
