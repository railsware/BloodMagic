.PHONY: all test ports

all: test

test: ports
	rake -f Specs/Rakefile Specs

ports:
	./ports.sh install
