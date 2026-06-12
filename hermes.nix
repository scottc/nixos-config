{ config, pkgs, ... }:

{
  home.username = "hermes";
  home.homeDirectory = "/home/hermes";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = [

  ];

  home.sessionVariables = {

  };

  home.file = {

  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
