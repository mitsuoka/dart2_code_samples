import 'dart:isolate';

// message queue
var logMessages = [];

main() async {
  // independent calculation
  log('start fib(40) calculation');
  fib(40);
  log('finished fib(40) calculation');

  // parallel calculation
  var receivePort = new ReceivePort();
  var isolate = await Isolate.spawnUri(
      Uri.parse('fibonacci_child.dart'), [''], receivePort.sendPort);
  isolate.addOnExitListener(receivePort.sendPort);
  receivePort.listen((message) {
    if (message is SendPort) {
      message.send('start');
      doCalc();
    } else if (message == null) {
      print("Child exited");
      receivePort.close();
    } else {
      print('Message: ${message}');
    }
  });
}

// log the message
void log(String msg) {
  String timestamp = new DateTime.now().toString().substring(11);
  msg = '$timestamp : $msg';
  print(msg);
  logMessages.add(msg);
}

// calculate fibonacci
doCalc(){
  log('start fib(40) parallel calculation in the parent');
  fib(40);
  log('finished fib(40) parallel calculation in the parent');
}

// Fibonacci function
int fib(int i) {
  if (i < 2) return i;
  return fib(i - 2) + fib(i - 1);
}
