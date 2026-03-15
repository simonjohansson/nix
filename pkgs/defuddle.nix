{
  buildNpmPackage,
  fetchFromGitHub,
  lib,
}:

buildNpmPackage rec {
  pname = "defuddle";
  version = "0.12.0";

  # The CLI was merged into the main defuddle package, and the nixpkgs
  # defuddle-cli recipe is currently broken against its upstream lockfile.
  src = fetchFromGitHub {
    owner = "kepano";
    repo = "defuddle";
    tag = version;
    hash = "sha256-Fvst82lUBLBixAFpjuerfS8ZEcLCfwgRXPLEcOQW0js=";
  };

  npmDepsHash = "sha256-WUr8P1pIFnOoKV+blpFv7B6zSh2HeRRdqBeOP5Pv0dc=";
  # The CLI imports jsdom at runtime, but upstream only declares it as a
  # dev/peer dependency, so pruning dev dependencies breaks the executable.
  dontNpmPrune = true;

  meta = {
    description = "Extract clean html, markdown and metadata from web pages";
    homepage = "https://github.com/kepano/defuddle";
    license = lib.licenses.mit;
    mainProgram = "defuddle";
  };
}
