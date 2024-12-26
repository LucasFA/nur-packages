{
  stdenv,
  lib,
  pkgs,
  fetchFromGitHub,
  pkg-config,
  meson,
  ninja,
  #glib,
  #libintl,
}:

stdenv.mkDerivation rec {
  pname = "libslimbook";
  version = "1.17.0";

  src = fetchFromGitHub {
    owner = "Slimbook-Team";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-c8WAWrLST99CBzisFAIXnP7LYhHKisCWg4g/ZunrN+Y=";
  };
  enableParallelBuilding = true;

  nativeBuildInputs = with pkgs; [
    gcc
    # make
    pkg-config
    # binutils
    meson
    ninja
  ];
  buildInputs = [ ];
  # buildInputs = [ glib libintl ]
  #buildPhase = "echo Hello World";

  # buildPhase = "echo echo Hello World > example";
  # installPhase = "install -Dm755 example $out";
  meta = with lib; {
    broken = false;
    description = "";
    homepage = "https://github.com/Slimbook-Team/${pname}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
