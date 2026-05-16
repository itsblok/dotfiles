{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking
  networking.hostName = "pi";
  networking.networkmanager.enable = true;

  # time & locale
  time.timeZone = "America/Denver";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    lc_address = "en_US.UTF-8";
    lc_identification = "en_US.UTF-8";
    lc_measurement = "en_US.UTF-8";
    lc_monetary = "en_US.UTF-8";
    lc_name = "en_US.UTF-8";
    lc_numeric = "en_US.UTF-8";
    lc_paper = "en_US.UTF-8";
    lc_telephone = "en_US.UTF-8";
    lc_time = "en_US.UTF-8";
  };

  # xserver
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.options = "caps:escape";
  };

  # security
  security.rtkit.enable = true;
  security.polkit.enable = true;

  # audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.blok = {
    isNormalUser = true;
    shell = pkgs.fish;

    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "docker"
    ];
  };

  services.greetd = {
    enable = true;

    settings.default_session = {
      user = "greeter";
      command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${config.programs.sway.package}/bin/sway";
    };
  };

  # system services
  services.dbus.enable = true;
  services.fwupd.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # desktop
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    package = pkgs.swayfx;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  programs.fish.enable = true;
  programs.zoxide.enable = true;
  programs.starship.enable = true;
  programs.direnv.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.containerd.enable = true;

  services.k3s = {
    enable = true;
    role = "server";

    extraFlags = toString [
      "--disable=traefik"
    ];
  };

  # packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    wget
    curl
    git

    hugo
    gcc
    gnumake
    cmake
    nodejs
    yarn
    pnpm
    bun
    go
    gopls
    delve
    rustup
    protobuf
    kubectl
    kubernetes-helm
    k9s
    k3s
    jq

    ripgrep
    eza
    bat
    fd
    fzf
    lazygit
    tldr
    coreutils
    ffmpeg

    awscli2
    terraform

    ghostty
    foot
    waybar
    rofi
    mako
    wl-clipboard
    wl-mirror
    grim
    slurp
    playerctl
    pavucontrol
    brightnessctl

    brave
    discord
    slack
    obs-studio
    proton-vpn

    postgresql
    stripe-cli

    vim
    neovim
    
    stow
    tmux
    bluez
    blueman

    nerd-fonts._0xproto
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts._0xproto
      ibm-plex
      openmoji-color
    ];

    fontconfig.defaultFonts = {
      sansSerif = [ "IBM Plex Sans" ];
      serif = [ "IBM Plex Serif" ];
      monospace = [ "0xProto Nerd Font" ];
      emoji = [ "OpenMoji Color" ];
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11";
}
