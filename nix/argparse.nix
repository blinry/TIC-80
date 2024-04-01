{ lib
, stdenv
, fetchFromGitHub
}:
stdenv.mkDerivation rec {
  name = "argparse";

  src = fetchFromGitHub {
    owner = "cofyc";
    repo = "argparse";
    rev = "c612dc03958cdbd538ca306d61853b643a435933";
    hash = "sha256-PXTv717FUluWOCPj8SaVA9gTgxn9RT2VaCMVSAFNmbI=";
  };

  installPhase = ''
    ls *
    install -Dm755 libargparse.so $out/lib/libargparse.so
    install -Dm644 argparse.h $out/include/argparse.h
  '';
}
