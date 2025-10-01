#!/bin/sh

# Update the lock file, with new pinned versions
nix flake update --flake .

# TODO: commit changes to git, then deploy

# Deploy to to /etc/nixos
sudo cp *.{nix,lock} /etc/nixos/

# Apply Build
sudo nixos-rebuild switch --flake /etc/nixos#nixos
