# A simple, raw WebAssembly demo for macOS-based developers

This is an attempt to show off the process of writing a simple function in C, compiling it to WebAssembly, and calling it from both Node.js and the Web browser, as of April 2019.

There's a lot of out of date guides out there, so the goal here is to keep things both as simple as possible and working using the norms of early 2019.

*Note: This is aimed at macOS-based users. Everything will be generally fine for Linux users too, but installing a recent version of LLVM/clang (or even Emscripten) is a real minefield unless you know what you're doing.*

## Write a function in C

Here's a basic Fibonacci sequence algorithm written in C:

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

Store that in a file called `fib.c`

## How to Compile the C to WebAssembly

You need to be running the latest version of [llvm/clang](https://llvm.org/) for the compilation to be relatively straightforward. The version of clang that comes with macOS/Xcode is NOT suitable.

On macOS with [homebrew](https://brew.sh/) installed, run `brew install llvm`

Once you have `clang` in play, this is how to compile `fib.c` to `fib.wasm`:

```
/usr/local/opt/llvm/bin/clang fib.c -o fib.wasm --target=wasm32 -nostdlib -fvisibility=default -Xlinker --no-entry -Xlinker -export-dynamic
```

You should now have a `fib.wasm` file to play with.

@julien has supplied a `Makefile` which also runs the above, though note you may need to prefix running `make` with a different `PATH` if you are using a separate build of `clang` like above. For example:

```
PATH=/usr/local/opt/llvm/bin:$PATH make
```

## How to run the WebAssembly in Node.js

Using a recent version of Node (8+):

```
node node.js
```

Read the source code for the mechanism involved.

## How to run the WebAssembly in the browser

Serve `index.html` over HTTP. The easiest way to do this on most systems is:

```
python -m SimpleHTTPServer 3000
```

Then navigate to http://localhost:3000/

Read the source code for the mechanism involved and some extra comments on its operation.
