import 'dart:isolate';

// message queue
var logMessages = [];

main(List<String> args, SendPort sendPort)  async {
  var receivePort = new ReceivePort();
  sendPort.send(receivePort.sendPort);
  await for (var msg in receivePort) {
    if (msg == 'start') doCalc();
    receivePort.close();
  }
}

// return log to the parent
void log(String msg) {
  String timestamp = new DateTime.now().toString().substring(11);
  msg = '$timestamp : $msg';
  print(msg);
  logMessages.add(msg);
}

// calculate fibonacci
doCalc(){
  log('start fib(40) parallel calculation in the child');
  fib(40);
  log('finished fib(40) parallel calculation in the child');
}

// Fibonacci function
int fib(int i) {
  if (i < 2) return i;
  return fib(i - 2) + fib(i - 1);
}
