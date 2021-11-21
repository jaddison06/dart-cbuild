.PHONY: codegen

all: codegen libraries

libraries: build/native/libHelloWorld.so

codegen:
	python codegen/main.py

run: all
	dart run

clean:
	rm -rf build
	rm -f native/c_codegen.h
	rm -f bin/dart_codegen.dart
	rm -f .cloc_exclude_list.txt

cloc:
	cloc . --exclude-list=.cloc_exclude_list.txt

cloc-by-file:
	cloc . --exclude-list=.cloc_exclude_list.txt --by-file

build/native/libHelloWorld.so: native/HelloWorld.c
	mkdir -p build/native
	gcc -shared -o build/native/libHelloWorld.so -fPIC -I. native/HelloWorld.c

