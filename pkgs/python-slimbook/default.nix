{
  stdenv,
  lib,
  fetchFromGithub,
  python3,
  python3Packages,
  pkg-config,
  meson,
  ninja,
  #glib,
  #libintl,
}:

python3Packages.buildPythonApplication rec {
  dependencies = [ python3 ] ++
  (with python3Packages; [
    configparser
    pygobject3 # gi
    utils
    # slimbook # python-slimbook
  ]);
