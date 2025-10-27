![Screenshot](https://i0.wp.com/www.omgubuntu.co.uk/wp-content/uploads/2025/09/cosmic-desktop.jpg?ssl=1)

# scottc's NixOS Config

My opinionated NixOS system and user configuration.

Feel free to use, fork, or suggest changes.

## Disclaimer

Important Note: The [hardware-configuration.nix](./hardware-configuration.nix), is specifically configured for my Lenovo T580 Thinkpad.

For this NixOS config to be portable, you'll need to supply your own [hardware-configuration.nix](./hardware-configuration.nix).

Please read the source, and verify that everything meets your needs prior to installing. As I've only tested this on my specific Lenovo T580 Thinkpad. And as such, it's not suitable for other devices.

## Features

This repo uses the [nix flakes](https://nixos.wiki/wiki/Flakes) and [home manager](https://nixos.wiki/wiki/Home_Manager) features, for reproducability.

Packages are:

* `allowUnfree = true` [options](https://search.nixos.org/options?channel=unstable&query=allowUnfree)
* [unstable](https://search.nixos.org/packages?channel=unstable) branch.

Note: It's possible, to have packages installed from both `unstable` branch and/or a stable branch like `24.11` if needed, see `flake.nix` inputs section, you'll need to pass the inputs to the config.

I prefer to have the latest bleeding edge packages, and remembering to bump the stable version number can be tedious. The ability to rollback makes bugs less of an issue. Stable could be preferred, when stability is of high importance.

### System

* [Flakes](https://nixos.wiki/wiki/Flakes)
* [Home Manager](https://nixos.wiki/wiki/Home_Manager)
* `git` [options](https://search.nixos.org/options?channel=unstable&query=git)
* `cosmic` [options](https://search.nixos.org/options?channel=unstable&query=cosmic) [website](https://system76.com/cosmic) (because, session manager, aka login screen)
* `steam` [options](https://search.nixos.org/options?channel=unstable&query=steam)  (could probably be installed on a per user basis)

### User

* `mpv` [package](https://search.nixos.org/packages?channel=unstable&query=mpv)
* `brave` [package](https://search.nixos.org/packages?channel=unstable&query=brave)
* `hexchat` [package](https://search.nixos.org/packages?channel=unstable&query=hexchat)
* `libreoffice` [package](https://search.nixos.org/packages?channel=unstable&query=libreoffice)
* `lutris` [package](https://search.nixos.org/packages?channel=unstable&query=lutris)
* `lapce` [package](https://search.nixos.org/packages?channel=unstable&query=lapce)
* `helix` [package](https://search.nixos.org/packages?channel=unstable&query=helix)
* `gimp` [package](https://search.nixos.org/packages?channel=unstable&query=gimp)
* `inkscape` [package](https://search.nixos.org/packages?channel=unstable&query=inkscape)
* `lbry` [package](https://search.nixos.org/packages?channel=unstable&query=lbry) (Note: needs workaround to get started, see [issue](https://github.com/NixOS/nixpkgs/issues/119933).)
* `superTuxKart` [package](https://search.nixos.org/packages?channel=unstable&query=superTuxKart)

## Files

* [flake.nix](./flake.nix) - The nix flake entry point.
* [flake.lock](./flake.lock) - The lock file, exact versions.
* [configuration.nix](./configuration.nix) - The system wide config.
* [home.nix](./home.nix) - The home manager, user config.
* [hardware-configuration.nix](./hardware-configuration.nix) - The hardware config, this should probably be `.gitignore`'d for portability.
* [update.sh](./update.sh) - helper script to update the `flake.lock` file, and apply the `flake.nix` config.

## Trying the flake from the repo

Modern single user style.
```sh
# Update the flake.lock file in the repo, with new pinned versions
nix flake update --flake .

# Apply Build, from the repo
sudo nixos-rebuild switch --flake .#nixos
```

## [Optional] Copying the flake to /etc/nixos

Traditional style.

```sh
# Update the flake.lock file in the repo, with new pinned versions
nix flake update --flake .

# Save changes to git
git add *
git commit -m "nix flake update"

# Copy config from the repo to /etc/nixos
sudo cp *.{nix,lock} /etc/nixos/

# Apply Build, from the /etc/nixos directory.
sudo nixos-rebuild switch --flake /etc/nixos#nixos

# Push changes to origin
git push origin
```

Note: It's possible to delete `/etc/nixos/*`, and continue to sucessfully manage the OS. For beginners, it may be better to stick the traditional approach, due to consistancy of approch purposes, to help align with other online documentation resources when searching for help.