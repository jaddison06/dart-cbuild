// Reinitialize the project structure

import 'dart:io';

void main(List<String> arguments) {
  print('Enter project name');
  // apparently when you run a standalone Dart file null safety gets disabled. Oh well
  final name = stdin.readLineSync()
    ..replaceAll('-', '_')
    ..replaceAll(' ', '_');

  // Reset & rename main Dart file
  File('bin/dart_cbuild.dart')
    ..writeAsStringSync(
'''void main(List<String> arguments) {

}
'''
  )..renameSync('bin/$name.dart');

  // Reset pubspec.yaml
  File('pubspec.yaml').writeAsStringSync(
'''name: $name
description: A simple command-line application.
version: 1.0.0
# homepage: https://www.example.com

environment:
  sdk: '>=2.12.0 <3.0.0'

dependencies: 
  ffi: ^1.1.2
  meta: ^1.7.0

dev_dependencies:
  pedantic: ^1.10.0
'''
  );

  // Reset README.md
  File('README.md').writeAsStringSync('# $name\n');

  // Remove reinit.dart
  File('reinit.dart').deleteSync();

  // Empty native
  Directory('native')
    ..deleteSync(recursive: true)
    ..createSync();

  // Rebuild makefile
  Process.runSync('make', ['codegen']);

  exit(0);
}