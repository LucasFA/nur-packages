{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
}:

stdenv.mkDerivation rec {
  pname = "qc71_slimbook_laptop";
  version = "0-unstable-2024-12-18";

  src = fetchFromGitHub {
    owner = "Slimbook-Team";
    repo = "qc71_laptop";
    rev = "e130a03628dfc12105f4832ecf59f487f32bcdd7";
    hash = "";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernel.makeFlags ++ [
    "VERSION=${version}"
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  installPhase = ''
    runHook preInstall
    install -D qc71_laptop.ko -t $out/lib/modules/${kernel.modDirVersion}/extra
    runHook postInstall
  '';

  meta = with lib; {
    description = "Linux driver for QC71 laptop with Slimbook patches";
    homepage = "https://github.com/Slimbook-Team/qc71_laptop/";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ LucasFA ];
    platforms = platforms.linux;
  };
}
