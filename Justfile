set shell := ["nu", "-c"]

default: build

build:
    $env.CC = "clang"
    $env.CFLAGS = "-march=native -O3 -fuse-ld=lld"
    $env.CXX = "clang++"
    $env.CXXFLAGS = "-march=native -O3 -fuse-ld=lld"
    cargo pgo build -- --bin rust-analyzer
    cargo pgo run -- --bin rust-analyzer analysis-stats . --run-all-ide-things
    cargo pgo optimize build -- --bin rust-analyzer
