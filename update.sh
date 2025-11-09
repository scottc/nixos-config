#!/bin/sh

# Fix dirty warning
git add *.{nix,lock,sh}

# Disabled updates, because some python package breaking the build... need to find & fix or remove the dependency...
# building python3.13-pyrate-limiter-3.9.0 (pytestCheckPhase): ........................................................................ [ 23%]

# Update the lock file, with new pinned versions
# nix flake update --flake .

# Fix dirty warning
git add *.{nix,lock,sh}

# Deploy to to /etc/nixos
sudo cp *.{nix,lock} /etc/nixos/

# Apply Build
sudo nixos-rebuild switch --flake /etc/nixos#nixos

# Save changes to git
git commit -m "nix flake update"
git push
