import 'dart:io';

Future main() async {
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    8080,
  );
  server.autoCompress = true;
  print('Listening on localhost:${server.port}');
  await for (HttpRequest request in server) {
    // 要求処理
    request.response
      ..write('Hello, world!')
      ..close();
  }
}