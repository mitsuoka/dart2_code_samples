import 'dart:isolate';
import 'dart:async';

void remote(SendPort replyTo) async {
  var receivePort = new ReceivePort();
  replyTo.send(receivePort.sendPort);
  await for (var msg in receivePort) {
    print('remote received : $msg');
    replyTo.send('Echo : $msg');
    if (msg == 'bar') {
      receivePort.close();
    }
  }
  ;
}

main() async {
  var receivePort = new ReceivePort();
  var sendPort = receivePort.sendPort;
  var requestTo; // SendPort to request echo back
  await Isolate.spawn(remote, sendPort);
  await for (var msg in receivePort) {
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
  }
  print("end of main");
}

/*
end of main
remote received : foo
received : Echo : foo
remote received : bar
received : Echo : bar
 */
