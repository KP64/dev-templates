{ self, inputs, ... }:
{
  perSystem =
    {
      inputs',
      lib,
      pkgs,
      ...
    }:
    let
      toolchain = inputs'.fenix.packages.fromToolchainFile {
        file = "${self}/rust-toolchain.toml";
        sha256 = lib.fakeSha256; # TODO: Add Sha
      };
      naersk' = pkgs.callPackage inputs.naersk {
        cargo = toolchain;
        rustc = toolchain;
      };

      manifest = (lib.importTOML "${self}/Cargo.toml").package;
    in
    {
      packages.default = naersk'.buildPackage {
        pname = manifest.name;
        inherit (manifest) version;

        src = lib.fileset.toSource {
          root = ../.;
          fileset = lib.fileset.unions [
            ../.cargo
            ../Cargo.toml
            ../Cargo.lock

            ../src
          ];
        };

        nativeBuildInputs = lib.optional pkgs.stdenv.isLinux pkgs.mold;

        # TODO: Add Metadata
        meta = {
          description = "";
          homepage = "";
          license = lib.licenses.unlicense;
          mainProgram = "";
        };
      };
    };
}
