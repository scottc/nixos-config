#!/bin/sh

cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch

