set export

default: build

CC := "clang"
CFLAGS := "-march=native -O3 -flto"
CXX := "clang++"
CXXFLAGS := "-march=native -O3 -flto"
RUSTFLAGS := "-C target-cpu=native -C linker=clang -C link-arg=-fuse-ld=lld -C linker-plugin-lto -C target-feature=+crt-static"

build:
    cargo pgo build -- --bin rust-analyzer
    cargo pgo run -- --bin rust-analyzer analysis-stats . --run-all-ide-things
    cargo pgo optimize build -- --bin rust-analyzer

install:
    cp target/x86_64-unknown-linux-gnu/release/rust-analyzer ~/.local/bin/rust-analyzer
