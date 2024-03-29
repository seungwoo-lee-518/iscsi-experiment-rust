{
  description = "Rust Dev Environments";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          overlays = [ (import rust-overlay) ];
          pkgs = import nixpkgs {
            inherit system overlays;
          };
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              rust-bin.stable.latest.default
              rust-analyzer
              openiscsi
            ];
          };
        }
      );
}
