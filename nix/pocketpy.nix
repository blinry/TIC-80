{ lib
, stdenv
, fetchFromGitHub
, cmake
}:
stdenv.mkDerivation rec {
  pname = "pocketpy";
  version = "1.4.3";

  src = fetchFromGitHub {
    owner = "pocketpy";
    repo = "pocketpy";
    rev = "v${version}";
    hash = "sha256-Vrfj6AVxu+mnGH9zEe4tlEaWz1HyOJAyqNUukuRnoq4=";
  };

  nativeBuildInputs = [ cmake ];

  installPhase = ''
    install -D -m755 libpocketpy.so $out/lib/libpocketpy.so
    cp -ar $src/include $out
  '';
}
