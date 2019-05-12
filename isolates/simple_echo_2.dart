import 'dart:isolate';
import 'dart:async';

void remote(SendPort replyTo) {
  var receivePort = new ReceivePort();
  replyTo.send(receivePort.sendPort);
  var streamSubscription;
  streamSubscription = receivePort.listen((msg) {
    print('remote received : $msg');
    replyTo.send('Echo : $msg');
    if (msg == 'bar') {
      streamSubscription.cancel();
    }
  });
}

main() {
  var receivePort = new ReceivePort();
  var sendPort = receivePort.sendPort;
  var requestTo; // SendPort to request echo back
  Isolate.spawn(remote, sendPort).then((_) {
    var streamSubscription;
    streamSubscription = receivePort.listen((msg) {
      if (msg is SendPort) {
        requestTo = msg;
        requestTo.send('foo');
      } else {
        print('received : $msg');
        requestTo.send('bar');
        if (msg.endsWith('bar')) {
          streamSubscription.cancel();
        }
      }
    });
  });
  print("end of main");
}