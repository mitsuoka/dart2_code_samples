import 'dart:isolate';

void main(List<String> args, SendPort sendPort) async {
  var receivePort = new ReceivePort();
  sendPort.send(receivePort.sendPort);
  // 最初のメッセージ受信とその処理を終えるまではこのアイソレートは生き続ける
  await for (var msg in receivePort) {
    print('${args[0]} isolate received: $msg');
    receivePort.close();
  }
}
