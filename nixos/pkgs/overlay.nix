{ ... }: final: prev: with final; {
	chibicc-uxn = callPackage ./chibicc-uxn {};
	playit-agent = callPackage ./playit-agent {};
	wxwabbitemu = callPackage ./wxwabbitemu {};
	ynodesktop = callPackage ./ynodesktop {};
}

