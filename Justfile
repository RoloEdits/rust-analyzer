set shell := ["nu", "-c"]

default: build

build:
	RUSTFLAGS='-C target-cpu=native' cargo build --release --bin rust-analyzer

clean:
	rm -r target/ 
