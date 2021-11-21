// Our Dart file! After all that hard work, we can finally start calling some C functions.

// The file with all the fancy stuff - if it's not there, run `make codegen`
import 'dart_codegen.dart';

void main(List<String> arguments) {
  
  print('Saying hello!');
  // libHelloWorld contains all the standalone functions from the library.
  libHelloWorld().HelloWorld();

  // You can assign the library to a variable, or just keep creating it - libraries only get imported
  // the first time, so there's barely any overhead.
  final libHW = libHelloWorld();
  print('\nSaying hello to the World and to Dart!');
  // You can use your Dart enums as normal!
  libHW.HelloEnums(Hello.World);
  libHW.HelloEnums(Hello.Dart);

  // Initialize our HelloWorldClass - notice that we can pass in a normal Dart string.
  final HW = HelloWorldClass('Boo!', 3);
  print('\nSaying boo a few times');
  // Methods work just like you'd expect...
  HW.Print();
  // ...and so do getters!
  print('\nThat was ${HW.times} times.');
  print('Once more!');
  // All your arguments work normally.
  HW.PrintN(1);

  // Dart doesn't have destructors, so don't forget to free memory!
  HW.Destroy();
}