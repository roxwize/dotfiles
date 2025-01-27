{ ... }: final: prev: with final; {
    chibicc-uxn = callPackage ./chibicc-uxn {};
    playit-agent = callPackage ./playit-agent {};
    ynodesktop = callPackage ./ynodesktop {};
}
