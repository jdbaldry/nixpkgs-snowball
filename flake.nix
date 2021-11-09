{
  description = "A very basic flake for building snowball stemwords";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/20.09;
  inputs.flake-utils.url = github:numtide/flake-utils;

  outputs = { self, nixpkgs, flake-utils }:
    {
      overlay =
        (
          final: prev: {
            snowball = prev.callPackage ./. { pkgs = prev; };
          }
        );
    } // (
      flake-utils.lib.eachDefaultSystem (
        system:
        let
          pkgs = import nixpkgs { inherit system; overlays = [ self.overlay ]; };
        in
        {
          packages.snowball = pkgs.snowball;
          defaultPackage = pkgs.snowball;
        }
      )
    );
}
