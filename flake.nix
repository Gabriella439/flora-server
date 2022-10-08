{ inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    utils.url = github:numtide/flake-utils;
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        compiler = "ghc92";

        config = { allowBroken = true; allowUnsupportedSystem = true; };

        overlay = pkgsNew: pkgsOld: {
          flora =
            pkgsNew.haskell.lib.justStaticExecutables
              pkgsNew.haskellPackages.flora;

          haskell =
            pkgsOld.haskell // {
              packages = pkgsOld.haskell.packages // {
                "${compiler}" =
                  pkgsOld.haskell.packages."${compiler}".override (old: {
                    overrides =
                      pkgsNew.lib.fold
                        pkgsNew.lib.composeExtensions
                        (old.overrides or (_: _: { }))
                        [ (pkgsNew.haskell.lib.packageSourceOverrides {
                            effectful-core = "1.0.0.0";

                            effectful = "1.0.0.0";

                            flora = ./.;
                          })
                          (pkgsNew.haskell.lib.packagesFromDirectory {
                            directory = ./nix;
                          })
                          (haskellPackagesNew: haskellPackagesOld: {
                            PyF = haskellPackagesNew.PyF_0_11_1_0;

                            raven-haskell =
                              pkgsNew.haskell.lib.dontCheck
                                haskellPackagesOld.raven-haskell;
                          })
                        ];
                  });
              };
            };
        };

        pkgs =
          import nixpkgs { inherit config system; overlays = [ overlay ]; };

      in
        rec {
          packages.default = pkgs.haskell.packages."${compiler}".flora;

          apps.default = {
            type = "app";

            program = "${pkgs.flora}/bin/flora";
          };

          devShells.default = pkgs.haskell.packages."${compiler}".flora.env;
        }
    );
}

