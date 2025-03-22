#! TODO
with import <nixpkgs> {};
stdenv.mkDerivation {
	pname = "vlink";
	version = "0.18";

	meta = with lib; {
		description = "A portable linker for multiple file formats";
	};
}
