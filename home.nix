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
    # pkgs.hello
    # pkgs.kitty
    # pkgs.kdePackages.dolphin
    # pkgs.wofi
    pkgs.brave
    pkgs.ladybird
    pkgs.hexchat
    pkgs.mpv
    pkgs.libreoffice

    # pkgs.git
    pkgs.jujutsu # A Distributed VCS, frontend like git, but with multiple backends, like git.
    pkgs.gg # a gui for jujutsu

    pkgs.lmstudio

    pkgs.lutris
    # pkgs.space-cadet-pinball


    # Install build tools and language servers via project specific flake,
    # so we can have per project versions installed.
    # then run "nix develop",
    # then run the desired code editor from within the dev environment,
    # which should detect the build tools and language server.
    #
    # pkgs.zig # Zig Compiler
    # pkgs.zls # Zig Language Server
    # pkgs.nil # nil (nix) Language Server

    pkgs.lapce # Code editor
    pkgs.helix # Code editor
    pkgs.zed-editor # depends on nodejs, which needs to be compiled from source and last time laptop went unresponsive
    pkgs.vscodium # Code editor

    pkgs.superTuxKart
    pkgs.gimp
    pkgs.inkscape
    pkgs.lbry
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
