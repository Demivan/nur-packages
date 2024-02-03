{
  stdenv,
  fetchurl,
  lib,
  autoPatchelfHook,
  pkgs ? import <nixpkgs> {}
}:
stdenv.mkDerivation rec {
  name = "catapult";
  version = "23.12a";

  src = fetchurl {
    url = "https://github.com/qrrk/Catapult/releases/download/${version}/catapult-linux-x64-${version}";
    sha256 = "sha256:1g0fgaha4macf01d7xsgnl9qwmz8chdkfs55lz4i75i57ay92iwg";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = with pkgs; [
    libGL
    xorg.libXrandr
    xorg.libXrender
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    install -m755 -D $src $out/bin/catapult
    runHook postInstall
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
