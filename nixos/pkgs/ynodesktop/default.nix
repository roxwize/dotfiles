{
    lib,
    stdenv,
    fetchFromGitHub,
    fetchYarnDeps,
    yarnConfigHook,
    yarnBuildHook,
    yarnInstallHook,
    imagemagick,
    makeWrapper,
    nodejs,
    electron,
    makeDesktopItem
}: stdenv.mkDerivation rec {
    pname = "ynodesktop";
    version = "1.2.3";

    src = fetchFromGitHub {
        owner = "affectioned";
        repo = pname;
        rev = version;
        sha256 = "1zr84mbc5p27f6ks4z2rkgg9cifzimf478f42bmz4yp44vrhaj1a";
    };

    yarnOfflineCache = fetchYarnDeps {
        yarnLock = "${src}/yarn.lock";
        hash = "sha256-EHoSypJWFC2k0ES6ZQxxrumBLx9H3E9YTniWf0V5nWc=";
    };

    env.ELECTRON_SKIP_BINARY_DOWNLOAD = 1;

    nativeBuildInputs = [
        yarnConfigHook
        yarnBuildHook
        yarnInstallHook
        imagemagick
        makeWrapper
        nodejs
    ];

    yarnBuildScript = "electron-builder";
    yarnBuildFlags = [
        "--dir"
        "-c.electronDist=${electron.dist}"
        "-c.electronVersion=${electron.version}"
    ];

    # TODO: also export the other icons from the .ico (i dont think theyre scaled properly though)
    installPhase = ''
        runHook preInstall

        mkdir -p $out/share/icons/hicolor/256x256/apps
        magick "assets/logo.ico[5]" "$out/share/icons/hicolor/256x256/apps/ynodesktop.png"

        mkdir -p $out/share/ynodesktop
        cp -r dist/*-unpacked/{locales,resources{,.pak}} $out/share/ynodesktop

        makeWrapper "${electron}/bin/electron" $out/bin/ynodesktop \
            --add-flags $out/share/ynodesktop/resources/app.asar \
            --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}" \
            --inherit-argv0

        runHook postInstall
    '';

    desktopItems = [(
        makeDesktopItem {
            name = pname;
            desktopName = "YNOdesktop";
            exec = "ynodesktop";
            icon = "ynodesktop";
            categories = [ "Game" ];
        }
    )];

    meta = with lib; {
        description = "A desktop client for Yume Nikki Online with Discord Rich Presence";
        homepage = "https://github.com/affectioned/ynodesktop";
        license = licenses.mit;
        platforms = platforms.linux;
    };
}
