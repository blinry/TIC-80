{
  lib,
  stdenv,
  fetchurl,
  cmake,
}:
stdenv.mkDerivation rec {
  pname = "msf_gif";
  version = "2.2";

  src = fetchurl {
    url = "https://github.com/notnullnotvoid/msf_gif/releases/download/v2.2/msf_gif.h";
    hash = "sha256-Z+tnXSZ9LJ9cMnXefE/skwl6/e388Tls+0UJC2QImsc=";
  };

  unpackPhase = ":";

  installPhase = ''
    install -D -m755 $src $out/include/msf_gif.h
  '';
}
