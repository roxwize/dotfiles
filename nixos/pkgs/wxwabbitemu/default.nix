{ stdenv, fetchFromGitHub, cmake, wxGTK32, lib }: stdenv.mkDerivation {
	pname = "wxwabbitemu";
	version = "0.1.0";

	src = fetchFromGitHub {
		owner = "alberthdev";
		repo = "wxwabbitemu";
		rev = "7b9ef9d3109355c053d83ae6be67cd75dd6ca8dc";
		sha256 = "035qlnk385qkkvwfhfd76cf70h5z2yhw0dzbay3pydx1qskn40dj";
	};

	nativeBuildInputs = [
		cmake
	];

	buildInputs = [
		wxGTK32
	];

	meta = with lib; {
		description = "Cross-platform TI-8x emulator based on Wabbitemu";
		homepage = "https://github.com/alberthdev/wxwabbitemu";
		license = licenses.gpl2;
		platform = platforms.linux;
	};
}
