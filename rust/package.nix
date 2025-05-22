{
  self,
  lib,
  rustPlatform,
  buildInputs,
  nativeBuildInputs,
}:

rustPlatform.buildRustPackage rec {
  pname = "";
  version = "";

  src = self;

  cargoLock = {
    lockFile = ./Cargo.lock;
    allowBuiltinFetchGit = true;
  };

  inherit buildInputs nativeBuildInputs;

  useNextest = true;

  # Remove this line when application has >= 1 tests.
  doCheck = false;

  meta = {
    description = "";
    homepage = "";
    license = lib.licenses.unlicense;
    maintainers = with lib.maintainers; [ ];
    mainProgram = pname;
  };
}
