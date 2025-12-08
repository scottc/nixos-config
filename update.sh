#!/bin/sh

# Fix dirty warning
git add *.{nix,lock,sh}

# Update the lock file, with new pinned versions
nix flake update --flake .

# Fix dirty warning
git add *.{nix,lock,sh}

# Deploy to to /etc/nixos
sudo cp *.{nix,lock} /etc/nixos/

# Apply Build
sudo nixos-rebuild switch --flake /etc/nixos#nixos

# Save changes to git
git commit -m "nix flake update"
git push
