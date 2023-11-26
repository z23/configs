# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "mbp";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Melbourne";

  i18n.defaultLocale = "en_AU.UTF-8";

  services.xserver.enable = true;

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  hardware.opengl.enable = true;

  #environment.sessionVariables = {
  #  NIXOS_OZONE_WL = "1";
  #};

  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.brendan = {
    isNormalUser = true;
    description = "brendan";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      chromium
      alacritty
      vscode
      remmina
      wireshark
      element-desktop
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
      weechat
      weechatScripts.wee-slack
    ];
  };

  home-manager.users.brendan = { pkgs, ... }: {
    home.packages = [ ];
    programs.kitty.enable = true;
    programs.kitty.font.name = "Terminess Nerd Font Mono";
    programs.kitty.font.size = 12;
    programs.kitty.extraConfig = "hide_window_decorations True";
    home.stateVersion = "23.05";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    btop
    htop
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
  programs.zsh.interactiveShellInit = "
    bindkey \'^R\' history-incremental-search-backward
  ";
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.traceroute.enable = true;
  programs.mtr.enable = true;
  programs.ssh.startAgent = true;

  services.locate.package = pkgs.plocate;
  services.locate.enable = true;
  services.locate.localuser = null;

  virtualisation.podman.enable = true;
  virtualisation.containers.enable = true;

  security.sudo.wheelNeedsPassword = false;

  services.openssh.enable = true;

  system.stateVersion = "23.05";

}
