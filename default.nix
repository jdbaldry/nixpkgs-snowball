{ pkgs ? import <nixpkgs> }:

with pkgs;
stdenv.mkDerivation rec {
  pname = "snowball";
  version = "2.1.0";

  buildInputs = [ perl ];

  src = fetchFromGitHub {
    owner = "snowballstem";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-VU+HM+Y+Myey/f45rJp1WQpzlfDT83p0esGTtojZ42M=";
  };

  preBuild = ''
    patchShebangs ./libstemmer/mkalgorithms.pl ./libstemmer/mkmodules.pl
    ./libstemmer/mkalgorithms.pl algorithms.mk ./libstemmer/modules.txt
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp stemwords $out/bin
  '';

  meta = with lib; {
    description = "Snowball compiler and stemming algorithms";
    homepage = "https://snowballstem.org";
    license = licenses.bsd3;
    maintainers = with maintainers; [ jdbaldry ];
  };
}
