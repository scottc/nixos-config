#!/bin/sh

# Update the lock file, with new pinned versions
nix flake update --flake .

# Save changes to git
git add *.{nix,lock}
git commit -m "nix flake update"
git push

# Deploy to to /etc/nixos
sudo cp *.{nix,lock} /etc/nixos/

# Apply Build
sudo nixos-rebuild switch --flake /etc/nixos#nixos

