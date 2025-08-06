{
  self,
  lib,
  makeRustPlatform,
  mold,
  pkg-config,
  rust-bin,
}:
let
  rustToolchain = rust-bin.fromRustupToolchainFile "${self}/rust-toolchain.toml";
  manifest = (lib.importTOML "${self}/Cargo.toml").package;
in
(makeRustPlatform rec {
  rustc = rustToolchain;
  cargo = rustc;
}).buildRustPackage
  rec {
    pname = manifest.name;
    inherit (manifest) version;

    src = self;

    cargoLock = {
      lockFile = "${self}/Cargo.lock";
      allowBuiltinFetchGit = true;
    };

    nativeBuildInputs = [
      mold
      pkg-config
    ];

    useNextest = true;

    # TODO: Remove this line when application has >= 1 tests.
    doCheck = false;

    meta = {
      description = "";
      homepage = "";
      license = lib.licenses.unlicense;
      maintainers = with lib.maintainers; [ ];
      mainProgram = pname;
    };
  }
