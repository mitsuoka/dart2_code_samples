import 'dart:isolate';
import 'dart:async' show Future, Stream, Completer;
import 'dart:io' as io;

class Child {
  String name;
  String status;

  Child(this.name);
}

void main() {
  final children = {
    'a': new Child('a'),
    'b': new Child('b'),
    'c': new Child('c')
  };
  children.forEach((name, child) async {
    var receivePort = new ReceivePort();
    var isolate = await Isolate.spawnUri(
        Uri.parse('sample_child_1.dart'), [name], receivePort.sendPort);
    isolate.addOnExitListener(receivePort.sendPort);
    receivePort.listen((message) {
      if (message is SendPort) {
        message.send('connected');
        child.status = 'running';
      } else if (message == null) {
        print("Child exited: ${child.name}");
        child.status = 'stopped';
      } else {
        print('Message: ${message}');
        child.status = 'running';
      }
      if (child.status == 'stopped') receivePort.close();
      print('status of the child $name : ${child.status}');
    });
  });
}
