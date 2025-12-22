{ config, pkgs, ... }:

{
  home.username = "anon";
  home.homeDirectory = "/home/anon";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = [
    # App Launchers
    # pkgs.wofi

    # File Managers
    # pkgs.kdePackages.dolphin

    # Web Browsers
    pkgs.brave
    # pkgs.ladybird
    # pkgs.servo

    # VCS ((Distributed) Version Control Systems)
    # pkgs.jujutsu # A Distributed VCS, frontend like git, but with multiple backends, like git.
    # pkgs.gg-jj # a gui for jujutsu
    # pkgs.git

    # AI - Artifical Inteligence
    # pkgs.lmstudio

    # Social & Communications
    pkgs.hexchat
    pkgs.telegram-desktop
    # pkgs.python313Packages.nomadnet # reticulum client
    # pkgs.rns # reticulum service


    # Multimedia
    pkgs.mpv
    pkgs.lbry
    pkgs.yt-dlp # Maintained youtube-dl fork.

    # Office Productivity Apps
    pkgs.libreoffice

    # Creative Productivity Apps
    pkgs.gimp
    pkgs.inkscape

    # Game Managers
    # pkgs.lutris

    # Games
    # pkgs.space-cadet-pinball
    # pkgs.superTuxKart

    # Shells
    # pkgs.kitty

    # Code editors
    pkgs.lapce # Code editor
    pkgs.helix # Code editor
    pkgs.zed-editor # Code editor
    pkgs.vscodium # Code editor

    # Compilers - Zig... probably install this in a nix develop environment, not per user.
    # pkgs.zig # Zig Compiler
    # pkgs.zls # Zig Language Server

    # Install build tools and language servers via project specific flake,
    # so we can have per project versions installed.
    # then run "nix develop",
    # then run the desired code editor from within the dev environment,
    # which should detect the build tools and language server.
    #
    # TODO: enable a nix language server to help lint these nix files...
    # pkgs.nil # nil (nix) Language Server
  ];

  # programs.steam = {
    # enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    # localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  # };

  home.sessionVariables = {

  };

  home.file = {

  };

  home.stateVersion = "24.11"; # Please read the comment before changing.

  programs.home-manager.enable = true;




  # programs.kitty.enable = true; # required for the default Hyprland config
  # wayland.windowManager.hyprland.enable = true; # enable Hyprland

  # Optional, hint Electron apps to use Wayland:
  # home.sessionVariables.NIXOS_OZONE_WL = "1";
}
