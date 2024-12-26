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
  buildInputs = with pkgs; [
    libinput
    efibootmgr
    usbutils
    pciutils
  ];

  # buildInputs = [ glib libintl ]
  #buildPhase = "echo Hello World";

  patches = [ ./flatpak.diff ./efi_and_lib.diff ];
  postPatch = ''
    substituteInPlace \
      src/slimbookctl.cpp \
        --replace-fail "/usr/libexec" "$out/libexec"
   '' 
+  ''
    substituteInPlace \
      slimbook-settings.service \
      slimbook-sleep \
        --replace-fail "/usr/bin" "$out/bin"
  ''
+ ''
    substituteInPlace \
      report.d/libinput \
        --replace-fail "libinput" "${pkgs.libinput}/bin/libinput"
  ''
+ ''
    substituteInPlace \
      report.d/efiboot \
        --replace-fail "efibootmgr" "${pkgs.efibootmgr}/bin/efibootmgr"
  ''
+ ''
    substituteInPlace \
      report.d/pci \
        --replace-fail "lspci" "${pkgs.pciutils}/bin/lspci"
  ''
+ ''
    substituteInPlace \
      report.d/usb \
        --replace-fail "lsusb" "${pkgs.usbutils}/bin/lsusb"
  '';
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
