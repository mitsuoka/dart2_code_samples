import 'dart:isolate';
import 'dart:async';

void remote(SendPort replyTo) {
  var receivePort = new ReceivePort();
  replyTo.send(receivePort.sendPort);
  receivePort.listen((msg) {
    print('remote received : $msg');
    replyTo.send('Echo : $msg');
    if (msg == 'bar') {
      receivePort.close();
    }
  });
}

main() {
  var receivePort = new ReceivePort();
  var sendPort = receivePort.sendPort;
  var requestTo; // SendPort to request echo back
  Isolate.spawn(remote, sendPort).then((_) {
    receivePort.listen((msg) {
      if (msg is SendPort) {
        requestTo = msg;
        requestTo.send('foo');
      } else {
        print('received : $msg');
        requestTo.send('bar');
        if (msg.endsWith('bar')) {
          receivePort.close();
        }
      }
    });
  });
  print("end of main");
}

/*
end of main
remote received : foo
received : Echo : foo
remote received : bar
received : Echo : bar
 */