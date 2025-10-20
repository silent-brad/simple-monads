{
  description = "Monad exploration in various languages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages = {
          nim = pkgs.stdenv.mkDerivation {
            pname = "monads-in-nim";
            version = "0.0.1";
            src = ./.;

            buildInputs = with pkgs; [ nim-2_0 ];

            buildPhase = ''
              mkdir -p $out/bin
              export HOME=$(pwd)
              ${pkgs.nim-2_0}/bin/nim c -d:release -o:$out/bin/monad-nim monad.nim
            '';
          };

          hs = pkgs.stdenv.mkDerivation {
            pname = "monads-in-haskell";
            version = "0.0.1";
            src = ./.;

            buildInputs = with pkgs; [ haskellPackages.ghc ];

            buildPhase = ''
              mkdir -p $out/bin
              ${pkgs.haskellPackages.ghc}/bin/ghc -o $out/bin/monad-hs ${
                ./monad.hs
              }
            '';
          };
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ nim-2_0 haskellPackages.ghc ];
        };
      });
}
