import 'dart:io';

main() {
  HttpServer.bind(InternetAddress.loopbackIPv4, 8080).then((HttpServer server) {
    print('Listening on localhost:${server.port}');
    server.listen((HttpRequest request) {
      // 到来要求処理
      request.response
        ..write('Hello, world!')
        ..close();
    });
  });
}
