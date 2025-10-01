### NixOS Config

`flake.nix` - The entry point.
`flake.lock` - The lock file, exact versions.
`configuration.nix` - The system wide config
`home.nix` - The user config
`hardware-configuration.nix` - The hardware config
`update.sh` - helper script to update the `flake.lock` file, and apply the `flake.nix` config.

