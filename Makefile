FLAGS:=--target=wasm32 -nostdlib -fvisibility=default -Xlinker --no-entry -Xlinker -export-dynamic
CC=clang
src=fib.c
bin=fib.wasm

$(bin): $(src)
	$(CC) $^ -o $@ $(FLAGS)

all: $(bin)
