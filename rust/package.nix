{
  self,
  lib,
  rustPlatform,
  mold,
  openssl,
  pkg-config,
  rust-bin,
}:
# TODO: Add metadata
rustPlatform.buildRustPackage rec {
  pname = "";
  version = "";

  src = self;

  cargoLock = {
    lockFile = "${self}/Cargo.lock";
    allowBuiltinFetchGit = true;
  };

  buildInputs = [ openssl ];

  nativeBuildInputs = [
    mold
    pkg-config
    (rust-bin.fromRustupToolchainFile "${self}/rust-toolchain.toml")
  ];

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
