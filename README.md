# A minimal C-to-WebAssembly pipeline, for Node/Bun and browsers

Write a function in C, compile it to WebAssembly, and call it from Node.js (or Bun) and the browser. No Emscripten, no bundlers, just [clang](https://clang.llvm.org/) and pure WASM.

This guide works on macOS Tahoe as of 2026, and on modern Linux distros.

> [!TIP]
> Surma has written [a fantastic tutorial](https://surma.dev/things/c-to-webassembly/) which goes much deeper into the stuff covered here.

## Requirements

You need a clang that supports the `wasm32` target and the LLVM linker (`lld`).

On macOS, Apple's built-in clang does not support `wasm32`, so install Homebrew's LLVM and lld:

```
brew install llvm lld
```

On Linux, the distro clang *should* be fine. Install `clang` and `lld` packages.

## Write a function in C

Here's a basic C function (in `fib.c`):

```c
int fib(int n) {
  int a = 0, b = 1, c = 0;

  for (int i = 1; i <= n; i++) {
    c = a + b;
    a = b;
    b = c;
  }

  return a;
}
```

## Compile to WebAssembly

```
make
```

The Makefile picks Homebrew's clang on macOS and the distro `clang` on Linux. You can also run the command directly:

```
clang fib.c -o fib.wasm \
  --target=wasm32 -nostdlib -fvisibility=default -fuse-ld=lld \
  -Xlinker --no-entry -Xlinker -export-dynamic
```

On macOS, replace `clang` with `$(brew --prefix llvm)/bin/clang`.

## Run in Node.js

```
node node.js
```

> [!TIP]
> `bun node.js` also works!

## Run in the browser

Serve over HTTP (needed for `WebAssembly.instantiateStreaming`):

```
python3 -m http.server 3000
```

Then open http://localhost:3000/

## Next?

If you want to go beyond basic C, things get complicated fast which is why lots of tooling dedicated to this task exists. Good luck!
