{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:
stdenv.mkDerivation rec {
  pname = "zip";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "kuba--";
    repo = "zip";
    rev = "v${version}";
    hash = "sha256-VGIDbhdBoLzU+7MQXmwe+SoMRYuYRWlNnW9NDTvejzg=";
  };

  buildInputs = [cmake];
}
