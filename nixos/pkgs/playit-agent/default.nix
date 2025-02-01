{ rustPlatform, fetchFromGitHub, lib }: rustPlatform.buildRustPackage rec {
    pname = "playit-agent";
    version = "0.15.26";

    src = fetchFromGitHub {
        owner = "playit-cloud";
        repo = "playit-agent";
        rev = "v" + version;
        sha256 = "12wc8am3zamjlkn61ajjw8kdvdrn9plvjnhskx56yspz9v9sys6f";
    };

    cargoHash = "sha256-JRsmZ5D/awsIjExGTDkzYkun6oeIpL1FkZJKzZf/XF0=";
    doCheck = false; # uses network tests and it also takes SO FUCKING LONG oh my god

    meta = with lib; {
        description = "The playit program";
        homepage = "https://playit.gg/";
        license = licenses.bsd2;
    };
}
