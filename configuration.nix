# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = with pkgs; [
    git
    vim
    curl
  ];

  environment.variables = {
    EDITOR = "vim";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.configurationLimit = 32;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.systemd-boot.editor = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  hardware.keyboard.zsa.enable = true;

  nix.settings = {
    tarball-ttl = 1;
    trusted-users = [ "dhaines" ];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd.network.enable = true;

  time.timeZone = "EST5EDT";

  documentation.man.generateCaches = true;

  hardware.bluetooth.enable = true;

  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.xkbOptions = "ctrl:nocaps";

  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;

  virtualisation.libvirtd.enable = true;
  networking.firewall.checkReversePath = false;

  virtualisation.docker.enable = true;

  services.openssh.enable = true;

  #services.qemuGuest.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.dhaines = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
