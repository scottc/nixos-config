# scottc's NixOS Config

My opinionated NixOS system and user configuration.

Feel free to fork, or suggest changes.

This repo uses the [nix flakes](https://nixos.wiki/wiki/Flakes) and [home manager](https://nixos.wiki/wiki/Home_Manager) features, for reproducability.

Important Note: The [hardware-configuration.nix](./hardware-configuration.nix), is specifically configured for my Lenovo T580 Thinkpad.

For this NixOS config to be portable, you'll need to supply your own [hardware-configuration.nix](./hardware-configuration.nix).

Please read the source, and verify that everything meets your needs prior to installing. As I've only tested this on my specific Lenovo T580 Thinkpad. And as such, it's not suitable for other devices.

## Files

[flake.nix](./flake.nix) - The nix flake entry point.

[flake.lock](./flake.lock) - The lock file, exact versions.

[configuration.nix](./configuration.nix) - The system wide config.

[home.nix](./home.nix) - The home manager, user config.

[hardware-configuration.nix](./hardware-configuration.nix) - The hardware config, this should probably be `.gitignore`'d for portability.

[update.sh](./update.sh) - helper script to update the `flake.lock` file, and apply the `flake.nix` config.



## Trying the flake from the repo
Modern single user style.
```sh
# Update the flake.lock file in the repo, with new pinned versions
nix flake update --flake .

# Apply Build, from the repo
sudo nixos-rebuild switch --flake .#nixos
```

## Copying the flake to /etc/nixos

Traditional style.

```sh
# Update the flake.lock file in the repo, with new pinned versions
nix flake update --flake .

# Copy config from the repo to /etc/nixos
sudo cp *.{nix,lock} /etc/nixos/

# Apply Build, from the /etc/nixos directory.
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```