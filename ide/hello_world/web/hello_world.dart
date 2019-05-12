import 'dart:html';

class HelloWorld {
  HelloWorld() {}

  void run() {
    write('*** Hello World! from Dart 2 ***');
  }

  void write(String message) {
    // the HTML library defines a global 'document' variable
    document.querySelector('#status').innerHtml = message;
  }
}

void main() {
  HelloWorld().run();
}
