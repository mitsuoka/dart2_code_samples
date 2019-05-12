// Sample Dart WebSocket echo server
// Source : https://github.com/dart-lang/sdk/issues/24278
import 'dart:io';

main() async {
  // Connect to a web socket.
  WebSocket socket = await WebSocket.connect('ws://127.0.0.1:8080/ws');

  // Setup listening.
  socket.listen((message) {
    print('message: $message');
  }, onError: (error) {
    print('error: $error');
  }, onDone: () {
    print('socket closed.');
  }, cancelOnError: true);

  // Add message
  socket.add('echo!');

  // Wait for the socket to close.
  try {
    await socket.done;
    print('WebSocket done');
  } catch (error) {
    print('WebScoket done with error $error');
  }
}