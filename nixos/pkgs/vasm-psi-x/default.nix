# TODO
with import <nixpkgs> {};
stdenv.mkDerivation rec {
	pname = "vasm-psi-x-m68k";
	version = "1.1.2";

	src = fetchFromGitHub {
		owner = "NaotoNTP";
		repo = "vasm-psi-x";
		rev = "v${version}";
		hash = "sha256-JuJoh99Dr1wDFbvpD28tgxyG/JH6B6NANoTVZnjhqf0=";
	};

	nativeBuildInputs = [ cmake ];

	cmakeFlags = [ "-DVASM_CPU=m68k" "-DVASM_SYNTAX=psi-x" ];

	meta = with lib; {
		description = "Portable and retargetable assembler (Motorola 68000)";
		homepage = "https://github.com/NaotoNTP/vasm-psi-x";
		license = licenses.free;
	};
}
