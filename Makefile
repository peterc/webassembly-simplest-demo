# On macOS, Apple's clang lacks the wasm32 target, so prefer Homebrew LLVM.
# On Linux, the distro clang is fine. Override with `make CC=...` if needed.
ifeq ($(origin CC),default)
  CC := $(shell command -v brew >/dev/null 2>&1 && echo $$(brew --prefix llvm)/bin/clang || echo clang)
endif
FLAGS := --target=wasm32 -nostdlib -fvisibility=default -fuse-ld=lld \
         -Xlinker --no-entry -Xlinker -export-dynamic
src = fib.c
bin = fib.wasm

all: $(bin)

$(bin): $(src)
	$(CC) $^ -o $@ $(FLAGS)

clean:
	rm -f $(bin)
