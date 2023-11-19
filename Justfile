default: build

flags := "-march=native -O3 -flto -fuse-ld=lld -ffunction-sections -fdata-sections -fvisibility=hidden -fomit-frame-pointer"

export CC := "clang"
export CXX := "clang++"
export CFLAGS := flags
export CXXFLAGS := flags
export RUSTFLAGS := "-Ctarget-cpu=native -Clinker=clang -Clink-arg=-fuse-ld=lld -Clink-args=-Wl,--icf=safe"

build:
    cargo +nightly build --release -Zbuild-std --bin rust-analyzer

pgo:
    cargo +nightly pgo build -- -Zbuild-std --bin rust-analyzer
    cargo +nightly pgo run -- -Zbuild-std --bin rust-analyzer analysis-stats --run-all-ide-things -q ../wezterm
    cargo +nightly pgo optimize build -- -Zbuild-std --bin rust-analyzer

install-pgo:
    cp target/x86_64-unknown-linux-gnu/release/rust-analyzer ~/.local/bin/rust-analyzer

install:
    cp target/release/rust-analyzer ~/.local/bin/rust-analyzer
