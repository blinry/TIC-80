{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  name = "blip-buf";

  src = fetchFromGitHub {
    owner = "nesbox";
    repo = "blip-buf";
    rev = "330226d9b55ecbeea644e17b5e0f096a165ca07e";
    hash = "sha256-DaROWL+Y1wkySj1lceW8GzbTeKZNDJArjQmua5pzzDs=";
  };

  buildPhase = ''
    gcc -shared $src/blip_buf.c -o blip_buf.so
    gcc -shared $src/wave_writer.c -o wave_writer.so
  '';

  installPhase = ''
    install -D -m755 blip_buf.so $out/lib/libblipbuf.so
    install -D -m755 wave_writer.so $out/lib/libwave_writer.so
    install -D -m644 $src/blip_buf.h $out/include/blip_buf.h
    install -D -m644 $src/wave_writer.h $out/include/wave_writer.h
  '';
}
