{ lib, stdenv, fetchFromGitHub }: stdenv.mkDerivation {
    pname = "chibicc-uxn";
    version = "1.0.0";

    src = fetchFromGitHub {
        owner = "lynn";
        repo = "chibicc";
        rev = "0a590db363fb8d69b80fc70d9dfb7e655aafe656";
        sha256 = "1jf18dh9ns0q79q8ql5yiw7l3zswyy0qjlz089xr3kw4zpqaqfmn";
    };

    installPhase = ''
        mkdir -p $out/bin
        cp chibicc $out/bin
    '';

    meta = with lib; {
        description = "A small C compiler... for uxn";
        homepage = "https://github.com/lynn/chibicc";
        license = licenses.mit;
        platforms = platforms.unix;
    };
}
