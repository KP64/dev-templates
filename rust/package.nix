{
  lib,
  rustPlatform,
  stdenv,
  darwin,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "";
  version = "";

  src = ./.;

  cargoLock = {
    lockFile = ./Cargo.lock;
    allowBuiltinFetchGit = true;
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    openssl
  ] ++ (lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.Security ]);

  useFetchCargoVendor = true;

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
