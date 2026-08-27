# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs,
  # hermes-agent, # temporary uninstalled.
  lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
              # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t550

      inputs.home-manager.nixosModules.home-manager
    ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;         # gives the Blueman GUI (highly recommended on KDE)

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    connect-timeout = 30;  # Timeout (seconds) for establishing connections to binary caches/servers
    max-silent-time = 1200;  # Timeout (seconds) for builds with no output (0 disables)
  };

  systemd.services.nix-daemon.environment = {
    NIX_CURL_FLAGS = "-4";  # Force IPv4-only for curl in Nix downloads, a workaround for "github:oxalica/rust-overlay", a fix for my home network... environment...
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  #networking.networkmanager.enable = true;
  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";  # Or "default-src" for DHCP
    };
    nameservers = [ "8.8.8.8" "1.1.1.1" ];
  };
  services.resolved.enable = true;
  # networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];
  # networking.enableIPv6 = false;
  # networking.firewall.enable = false;

  # Set your time zone.
  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;

  # programs.hyprland.enable = true;
  # # Optional, hint electron apps to use wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Cosmic DE
  # services.displayManager.cosmic-greeter.enable = true;
  # services.desktopManager.cosmic.enable = true;

  # KDE
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.settings.General.DisplayServer = "wayland";
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable input-remapper service, for keyboard macros
  services.input-remapper.enable = true;



  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # temporarily uninstalled...
  # services.hermes-agent = {
  #   enable = true;
  #   container.enable = true;
  #   container.hostUsers = [ "anon" ];

  #   # settings.model.default = "anthropic/claude-sonnet-4";  # or your preferred model
  #   # environmentFiles = [ config.sops.secrets."hermes-env".path ];  # for API keys
  #   environmentFiles = [ "/var/lib/hermes/hermes.env" ]; # plain text, You'll need to plugin your own API keys or whatever

  #   # Good defaults for container mode
  #   settings = {
  #     model.default = "google/gemini-2.5-pro";        # or gemini-2.5-flash for cheaper/faster
  #     model.fallback = "google/gemini-2.5-flash";

  #     # Context & quality settings
  #     context = {
  #       maxTokens = 128000;      # Gemini 2.5 supports very large context
  #       autoSummarize = true;
  #     };

  #     # Enable useful features
  #     tools = {
  #       enable = true;
  #       autoApprove = [ "read_file" "list_dir" ];   # be careful with this
  #     };

  #     terminal.backend = "container";   # Best for container mode
  #     sandbox.enable = true;

  #     # Optional: nice to have
  #     personality = {
  #       style = "helpful, concise, and technically precise";
  #     };
  #   };


  #   addToSystemPackages = true;  # puts `hermes` CLI on PATH + shares state
  #   package = hermes-agent.packages.${pkgs.system}.full;   # .full or .default # This pulls in edge-tts + web + desktop etc.
  # };

  # Passwordless docker access, for `hermes chat`
  security.sudo.extraRules = [{
    users = [ "anon" ];
    commands = [{ command = "/run/current-system/sw/bin/docker"; options = [ "NOPASSWD" ]; }];
  }];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
      # Anonymous user
      anon = {
        isNormalUser = true;
        description = "anon";
        extraGroups = [ "networkmanager" "wheel" "hermes" ];
        packages = with pkgs; [
          # Use home-manager instead.
        ];
      };

    # AI agent # seems the service, already creates a hermes user, and the home is "/var/lib/hermes" ... Hmmm.... unsure how i feel about that.
    # hermes = {
      #isNormalUser = true;
    #  description = "hermes";
    #  extraGroups = [ ];
    #  packages = with pkgs; [
    #    # Use home-manager instead.
    #  ];
    #};
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      # Anonymous user
      anon = import ./home.nix;
      # AI agent
      # hermes = import ./hermes.nix;
    };
  };


  # Install firefox.
  # programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];


      # mesa # steam depends on mesa for driver support? also requires hardware.graphics.enabled = true; ?
    # vulkan-tools
    # glxinfo
    # mesa-utils
    # steam #.withLibraries # depends on graphics drivers, vulkan and opengl... aka pkgs.mesa, hardware.graphics.enable = true;

  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    # localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };


  programs.git = {
    enable = true;
    lfs.enable = true;
  };


  # Workaround for dynamically linked applications, we can redirect them to libraries specified here...
  # List of apps, that required these shared objects...:
  # /home/anon/Projects/spirit-vale-overlay (neutralinojs)
  # /home/anon/Projects/spirit-vale-tools
  # This is so we can keep track of what is needed or can be cleanned up.
programs.nix-ld.enable = true;
programs.nix-ld.libraries = with pkgs; [
  # spirit-vale-overlay (neutralinojs) dependencies
  libxcb # libxcb.so.1
  gtk3 # libgtk-3.so.0
  cairo # libcairo.so.2
  gdk-pixbuf # libgdk_pixbuf-2.0.so.0
  glib # libgobject-2.0.so.0
  libx11 # libX11.so.6
  libxrandr # libXrandr.so.2
  libxtst # libXtst.so.6
  libpng # libpng16.so.16
  # spirit-vale-tools dependencies
  libpcap # libpcap.so
];
# In configuration.nix or a module
security.wrappers.bun-pcap = {
  source = "${pkgs.bun}/bin/bun";
  owner = "root";
  group = "root";
  capabilities = "cap_net_raw,cap_net_admin+eip";
};


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
