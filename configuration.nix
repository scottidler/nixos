# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # ./hardware-configuration.nix
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
    ];

  home-manager = {
    users = {
      saidler = import /home/saidler/.config/home-manager/home.nix;
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.finegrained = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  security.sudo = {
    enable = true;
    extraConfig = ''
      saidler ALL=(ALL) NOPASSWD: ALL
    '';
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    layout = "us";
    xkbVariant = "";

    # Enable the GNOME Desktop Environment.
    displayManager.gdm = {
      enable = true;
      wayland = false;
    };
    desktopManager.gnome.enable = true;
    displayManager.sddm.enableHidpi = true;
    videoDrivers = [ "nvidia" ];
    dpi = 192;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.saidler = {
    isNormalUser = true;
    description = "saidler";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    anki
    curl
    discord
    docker
    docker-compose
    firefox
    gcc
    gimp-with-plugins
    git
    gnome.gnome-terminal
    graphviz
    kitty
    kitty-themes
    openvpn
    pciutils
    pavucontrol
    pulsemixer
    pwgen
    python3
    #python311Packages.pip
    read-edid
    rustup
    slack
    spotify
    tldr
    tmux
    vim
    wget
    whois
    xclip
    xorg.xorgserver
    xorg.xrandr
    xorg.libxcvt
  ];

  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  environment.variables = {
    # GDK_SCALE = "0.5";
  };

  systemd.services.dotfilesClone = {
    description = "Clone Dotfiles Repository";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    script = ''
      if [ ! -d /home/saidler/dotfiles ]; then
        git clone https://github.com/scottidler/... /home/saidler/dotfiles
      else
        echo "Dotfiles directory already exists."
      fi
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "saidler";
      WorkingDirectory = "/home/saidler";
      Environment = "PATH=/run/current-system/sw/bin:/bin:/usr/bin";
    };
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

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
  system.stateVersion = "23.11"; # Did you read the comment?

}
