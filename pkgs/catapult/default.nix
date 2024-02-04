{
  stdenv,
  fetchFromGitHub,
  lib,
  godot3-headless,
  godot3-export-templates,
  libGL,
  xorg,
}:
stdenv.mkDerivation rec {
  name = "catapult";
  version = "23.12a";

  src = fetchFromGitHub {
    owner = "qrrk";
    repo = "Catapult";
    rev = version;
    sha256 = "sha256-HMQqfZ3s4l15qRYs6PBFCPA5UOQ8KBeDwcckHWKZ3dU=";
  };

  nativeBuildInputs = [
    godot3-headless
  ];

  buildInputs = [
    libGL
    xorg.libXrandr
    xorg.libXrender
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
  ];

  buildPhase = ''
    runHook preBuild

    # ERROR: Could not create directory: /homeless-shelter
    export HOME=$TMPDIR

    # Link the export-templates to the expected location. The --export commands
    # expects the template-file at .../templates/3.5.2.stable/linux_x11_64_release
    # with 3.5.2 being the version of godot.
    mkdir -p $HOME/.local/share/godot
    ln -s ${godot3-export-templates}/share/godot/templates $HOME/.local/share/godot

    mkdir -p $TMPDIR/src

    cp $src/. $TMPDIR/src -r
    cp ${./export_presets.cfg} $TMPDIR/src/export_presets.cfg
    chmod -R 777 $TMPDIR/src

    mkdir -p $out/bin
    godot3-headless --path $TMPDIR/src --export "Linux/X11" $out/bin/catapult

    runHook postBuild
  '';
  
  meta = with lib; {
    description = "A cross-platform launcher for Cataclysm: DDA and BN";
    longDescription = ''
    Catapult is a cross-platform launcher and content manager for Cataclysm: Dark Days Ahead 
    and Cataclysm: Bright Nights. It is in part inspired by earlier versions of Rémy Roy's launcher.
    '';
    homepage = "https://github.com/qrrk/Catapult";
    changelog = "https://github.com/qrrk/Catapult/releases/tag/${version}";
    license = licenses.mit;
  };
}
