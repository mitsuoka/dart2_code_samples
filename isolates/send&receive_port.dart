import 'dart:isolate';

class Sender {
  SendPort sendPort;
  String senderId;

  Sender(this.sendPort, this.senderId);

  run() {
    sendPort.send('received message from $senderId');
  }
}

main() {
  var receivePort = new ReceivePort();
  receivePort.forEach((msg) {
    print(msg);
    if(msg.endsWith('#2')) {
      receivePort.close();
    }
  });
  new Sender(receivePort.sendPort, 'sender #1').run();
  new Sender(receivePort.sendPort, 'sender #2').run();
  new Sender(receivePort.sendPort, 'sender #3').run();
}

/*
received message from sender #1
received message from sender #2
 */
