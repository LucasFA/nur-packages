{
  stdenv,
  lib,
  fetchFromGithub,
  python3,
  python3Packages,
  setuptools,
  pkg-config,
  meson,
  ninja,
}:

python3Packages.buildPythonPackage rec {
  pname = "python-slimbook";
  version = "0-unstable-2024-12-05";
  pyproject = true;
  src = fetchFromGithub {
    owner = "Slimbook-Team";
    repo = "python-slimbook";
    rev = "009ee634058c2d9bcc870cff40c1552e91e101b4";
    hash = "";
  };
  postPatch = ''
    # Fix license
  '';
  build-system = [
    setuptools
    libslimbok # Does this work? Need at runtime
    python3
  ];
  dependencies = [
    setuptools
    python3Packages.pygobject3 # gi
  ];
  meta = {
    description = "Python bindings for libslimbook";
    homepage = "https://github.com/Slimbook-Team/python-slimbook";
    license = lib.licenses.lgpl3Plus;
    # maintainers = with lib.maintainers; [ lucasfa ];

};
}
