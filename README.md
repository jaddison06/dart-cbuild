# Dart-CBuild

Dart-CBuild is a build system for seamless Dart/C interop. You write your C code, tell the system its signature, then call it from Dart. It's that simple.

# Dependencies

Dart-CBuild is written in Python 3. It is tested on Python 3.9 but should work in all recent versions. It generates Makefiles for GNU Make, and can optionally integrate with [cloc](https://github.com/AlDanial/cloc). You also need to have Dart installed. Obviously.

# Getting started

This repository includes an example to get you started. You'll want to have a read through `native/HelloWorld.c`, `native/HelloWorld.gen`, and `bin/dart_cbuild.dart` - those will tell you all you need to know. Then, type `make run` to see it in action.

# Creating your own project

To create your own project with Dart-CBuild, clone this repository and execute `dart run reinit.dart` to reinitialize the project structure.

# cloc

[cloc](https://github.com/AlDanial/cloc) is a command-line utility for counting lines of code. Dart-CBuild can generate an exclude list so cloc doesn't count generated files.

# Commands

Dart-CBuild generates a makefile with a number of commands that you can use.

|Command|Effect|
|-|-|
make codegen|Generates Dart & C code from .gen files
make libraries|Compiles C code into the `build` directory
make all|`make codegen` and `make libraries`
make run|`make all` and `dart run`
make cloc|Print a cloc summary
make cloc-by-file|Print a cloc breakdown by file

# Configuration

To configure Dart-CBuild, place a `codegen.yaml` file in your project root. Here are the settings you can change:

|Name|Usage|Default
|-|-|-|
definition_ext|The file extension for codegen definition files|.gen
definition_search_path|Where to search for definition files (subdirs also get searched recursively)|native
dart_output_path|Where to output generated Dart code|bin/dart_codegen.dart
c_output_path|Where to output generated C code|native/c_codegen.h
use_cloc|Whether to generate cloc integration|true
cloc_exclude_list_path|Where to generate the cloc exclude list|.cloc_exclude_list.txt

# Annotations

Supported annotations for use in .gen files.

## On a file
|Annotation|argc|Meaning|
|-|-|-|
@LinkWithLib|1|Link the corresponding C file with the specified library

## On a function
|Annotation|argc|Meaning|
|-|-|-|
@Show|1|Change the visible name of the generated function

## On an enum
None

## On a class
|Annotation|argc|Meaning|
|-|-|-|
@Prefix|1|C on this class all start with a certain prefix. You **should** still write the method's full name in your .gen file, but the corresponding Dart method will automatically have the prefix removed.

## On a class method
|Annotation|argc|Meaning|
|-|-|-|
Initializer|0|This method should be used to create structPointer. It will be called when the class is constructed using the default constructor.
Getter|1|This method will be generated as a getter using the given name.
Show|1|Same as on a function.
Invalidates|0|This method invalidates the pointer, probably by freeing memory. After it has been called, the pointer will be set to a nullptr, meaning any further operations on the class will raise an exception.