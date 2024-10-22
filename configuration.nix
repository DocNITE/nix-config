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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "25%";

  # This is for OBS Virtual Cam Support - v412loopback setup
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  networking.hostName = "redmibook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.docnite = {
    isNormalUser = true;
    description = "docnite";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the Flakes feature and the accompanying new nix cmd tools
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

   # Based editor and another tools
   vim wget curl cmatrix

   # Search packages
   nix-search-cli

   # Terminal emulator
   kitty starship

   # Archiver
   archiver kdePackages.ark

   # Browser
   firefox-bin

   # Games
   gzdoom

   # Status bar and widgets
   eww waybar

   # Editor, better than VIM
   neovim vscode neovide

   # System staff
   playerctl ffmpeg pkg-config brightnessctl

   # Script runtime
   lua python3 

   # Compilers
   gcc gnumake

   # Another packages
   noto-fonts-color-emoji swappy rar nh
   networkmanagerapplet material-icons wl-clipboard
   btop unzip unrar ripgrep killall bat tree
   lxqt.lxqt-policykit glib

   # Notifications
   dunst libnotify

   # Hypr's
   hyprpaper hyprpicker hypridle hyprlock hyprcursor

   # Application launcher
   rofi-wayland rofi-bluetooth rofi-emoji-wayland
   rofi-vpn rofi-obsidian rofi-power-menu

   # File manager
   yazi

   # Audio controller
   pavucontrol

   # LSP
   vscode-langservers-extracted nixd rust-analyzer
   lua-language-server hyprls

   # Cursor theme 
   bibata-cursors

   # Screenshots
   grim slurp
  ];

  # Install system fonts for the user.
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [
      "JetBrainsMono"
      "0xProto"
    ]; })
  ];

  # Theme QT -> GTK
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Enable Hyprland as WM.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable git as powerful tool.
  programs.git = {
    enable = true;
  };

  # dconf :woozy:
  programs.dconf = {
    enable = true;
    #settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  programs.seahorse.enable = true;
  programs.fuse.userAllowOther = true;

  # File manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ 
      thunar-archive-plugin 
      thunar-volman 
    ];
  };

  # Theme shell (starship)
  # programs.starship.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable nix-ld for running dynamicly libraries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      alsa-lib at-spi2-atk at-spi2-core atk cairo 
      cups curl dbus expat fontconfig freetype fuse3
      gdk-pixbuf glib gtk3 icu libGL libappindicator-gtk3
      libdrm libglvnd libnotify libpulseaudio libunwind
      libusb1 libuuid libxkbcommon libxml2 mesa nspr nss 
      openssl pango pipewire stdenv.cc.cc systemd 
      vulkan-loader xorg.libX11 xorg.libXScrnSaver 
      xorg.libXcomposite xorg.libXcursor xorg.libXdamage
      xorg.libXext xorg.libXfixes xorg.libXi xorg.libXrandr
      xorg.libXrender xorg.libXtst xorg.libxcb xorg.libxkbfile
      xorg.libxshmfence zlib
    ];
  };

  # Virtual manager for VM
  programs.virt-manager.enable = true;

  # Enable virtualization
  virtualisation.libvirtd.enable = true;

  # List environment variables:

  # Set the default system editor.
  environment.variables.EDITOR = "vim";

  # Enable OZONE for running electron apps under wayland.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # List services that you want to enable:

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Login screen manager
  services.displayManager.ly.enable = true;

  services.libinput.enable = true;

  # services.xserver.enable = true;
  # For AMD
  # services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.fstrim.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.gvfs.enable = true;

  services.tumbler.enable = true;

  services.gnome.gnome-keyring.enable = true;

  # Bluetooth manager
  services.blueman.enable = true;

  # Disable default power profiles, use TLP instead
  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOTS_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  services.thermald.enable = true;

  # GAOMON s620 tablet pen resolution fix
  services.udev.extraHwdb = ''
  evdev:input:b0003v256Cp006F*
    EVDEV_ABS_00=::210
    EVDEV_ABS_01=::323
    EVDEV_ABS_35=::210
    EVDEV_ABS_36=::323
  '';

  # Enable flatpak
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # List hardware features:

  hardware.bluetooth.enable = true;

  hardware.bluetooth.powerOnBoot = true;

  hardware.pulseaudio.enable = false;

  # OpenGL
  hardware.graphics = {
    enable = true;
    # For AMD
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  # List some security features:

  security.rtkit.enable = true;

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
  system.stateVersion = "24.05"; # Did you read the comment?

}
