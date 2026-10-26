# quiver-launcher.nix
{
  lib,
  appimageTools,
  fetchurl,
  icu,
  openssl,
  zlib,
  libGL,
  xorg,
  fontconfig,
  freetype,
  libxkbcommon,
  wayland,
  ...
}:

let
  pname = "quiver-launcher";
  version = "3.5.1";

  src = fetchurl {
    url = "https://github.com/tgeorgiadis/quiver-launcher/releases/download/v${version}/QuiverLauncher-linux-x64.AppImage";
    # Run once with a wrong hash (or leave empty) and Nix will tell you the correct one:
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";  # replace after first build
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  # Critical: give the .NET AppImage ICU + common Avalonia/OpenGL deps
  extraPkgs = pkgs: with pkgs; [
    icu
    openssl
    zlib
    libGL
    fontconfig
    freetype
    libxkbcommon
    wayland
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libXext
    # add more here if strace / ldd shows missing .so files later
  ];

  extraInstallCommands = ''
    # Nice binary name
    mv $out/bin/${pname}-${version} $out/bin/${pname} || true
    ln -sf $out/bin/${pname} $out/bin/QuiverLauncher || true

    # Desktop entry + icon (best-effort)
    mkdir -p $out/share/applications $out/share/icons/hicolor/256x256/apps
    if [ -f ${appimageContents}/quiver-launcher.desktop ] || [ -f ${appimageContents}/*.desktop ]; then
      cp ${appimageContents}/*.desktop $out/share/applications/ 2>/dev/null || true
      substituteInPlace $out/share/applications/*.desktop \
        --replace-fail 'Exec=AppRun' "Exec=$out/bin/${pname}" \
        --replace-fail 'Exec=QuiverLauncher' "Exec=$out/bin/${pname}" || true
    else
      cat > $out/share/applications/quiver-launcher.desktop <<EOF
[Desktop Entry]
Name=Quiver Launcher
Comment=Launcher for GitHub/GitLab releases
Exec=$out/bin/${pname}
Icon=quiver-launcher
Type=Application
Categories=Game;Utility;
EOF
    fi

    # Icon (if present inside the AppImage)
    find ${appimageContents} -name "*.png" -o -name "*.svg" | head -1 | xargs -I{} cp {} $out/share/icons/hicolor/256x256/apps/quiver-launcher.png 2>/dev/null || true
  '';

  meta = with lib; {
    description = "Modern launcher for downloading, installing and running apps from GitHub and GitLab releases";
    homepage = "https://quiverlauncher.com";
    downloadPage = "https://github.com/tgeorgiadis/quiver-launcher/releases";
    license = licenses.mit; # check the actual LICENSE in the repo
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    mainProgram = "quiver-launcher";
  };
}
