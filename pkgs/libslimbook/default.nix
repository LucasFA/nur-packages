{
  stdenv,
  lib,
  pkgs,
  fetchFromGitHub,
  pkg-config,
  meson,
  ninja,
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
    pkg-config
    meson
    ninja
  ];
  buildInputs = with pkgs; [
    libinput
    efibootmgr
    usbutils
    pciutils
    # qc71_slimbook_laptop
  ];

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

  meta = with lib; {
    description = "";
    homepage = "https://github.com/Slimbook-Team/${pname}";
    license = licenses.lgpl3Plus;
    platforms = platforms.linux;
  };
}
