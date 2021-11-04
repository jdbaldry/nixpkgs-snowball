{
  description = "A very basic flake for building snowball stemwords";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/20.09;
  inputs.flake-utils.url = github:numtide/flake-utils;

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
          rec {
            packages.snowball = import ./. { inherit pkgs; };
            defaultPackage = packages.snowball;
          }
    );
}
