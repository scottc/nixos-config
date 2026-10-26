# quiver-launcher.nix
{ lib
, appimageTools
, fetchurl
, icu
, openssl
, zlib
, libGL
, libx11
, libxcursor
, libxrandr
, libxi
, libxext
, fontconfig
, freetype
, libxkbcommon
, wayland
, fuse
, fuse3
, libdecor
, ...
}:

let
  pname = "quiver-launcher";
  version = "3.5.1";

  src = fetchurl {
    url = "https://github.com/tgeorgiadis/quiver-launcher/releases/download/v${version}/QuiverLauncher-linux-x64.AppImage";
    hash = "sha256-qM1TmLba6SS87Ans4XgcA8v9cymGdUdvJvwcBy08Yps=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [
    icu
    openssl
    zlib
    libGL
    fontconfig
    freetype
    libxkbcommon
    wayland
    fuse
    fuse3
    libdecor
    libx11
    libxcursor
    libxrandr
    libxi
    libxext
  ];

  # Make the setuid FUSE wrappers visible to nested AppImages
  profile = ''
    export FUSERMOUNT_PROG=/run/wrappers/bin/fusermount3
    export PATH=/run/wrappers/bin:$PATH
  '';

  extraInstallCommands = ''
    # Clean binary name
    mv $out/bin/${pname}-${version} $out/bin/${pname} || true
    ln -sf $out/bin/${pname} $out/bin/QuiverLauncher || true

    mkdir -p $out/share/applications $out/share/icons/hicolor/256x256/apps

    # Proper desktop file (fixes the kf.service warning)
    cat > $out/share/applications/QuiverLauncher.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Quiver Launcher
Comment=Modern launcher for GitHub / GitLab releases
Exec=${pname}
Icon=quiver-launcher
Terminal=false
Categories=Game;Utility;
StartupNotify=true
EOF

    # Best-effort icon
    find ${appimageContents} \( -name "*.png" -o -name "*.svg" \) | head -1 \
      | xargs -I{} cp {} $out/share/icons/hicolor/256x256/apps/quiver-launcher.png 2>/dev/null || true
  '';

  meta = with lib; {
    description = "Launcher for downloading and running apps from GitHub/GitLab releases";
    homepage = "https://quiverlauncher.com";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = "quiver-launcher";
  };
}
