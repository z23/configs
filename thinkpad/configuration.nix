# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos> 

    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # thinkpad specific
  networking.hostName = "thinkpad";
  #services.tlp.enable = true;
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  services.xserver.enable = true;

  #services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  hardware.opengl.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.brendan = {
    isNormalUser = true;
    description = "brendan";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      google-chrome
      alacritty
      slack
      slack-term
      vscode
      spotify
      brave
      remmina
      wireshark
      element-desktop
      spotify
      wofi
      rofi-wayland
      waybar
      mako
      dunst
      libnotify
      swww
      grim
      slurp
      wl-clipboard
    ];
  };
  home-manager.users.brendan = { pkgs, ... }: {
    home.packages = [ pkgs.htop ];
    programs.kitty.enable = true;
    programs.kitty.font.name = "Terminess Nerd Font Mono";
    programs.kitty.font.size = 12;
    programs.kitty.extraConfig = "hide_window_decorations True";
    home.stateVersion = "23.05";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    btop
    distrobox
    neofetch
    whois
    terminus-nerdfont
    tcpdump
    curl
    file
    jq
  ];

  programs.git.enable = true;
  programs.tmux.enable = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.histSize = 5000;
  programs.zsh.histFile = "~/.histfile";
  programs.zsh.enableLsColors = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.traceroute.enable = true;
  programs.mtr.enable = true;
  programs.ssh.startAgent = true;

  services.locate.package = pkgs.plocate;
  services.locate.enable = true;
  services.locate.localuser = null;

#  services.wg-netmanager.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.containers.enable = true;

  security.sudo.wheelNeedsPassword = false;

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
  system.stateVersion = "23.05"; # Did you read the comment?

}
