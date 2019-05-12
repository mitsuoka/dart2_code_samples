import 'dart:io';
import 'dart:async';

final HOST = "127.0.0.1";
final PORT = 8080;
final LOG_REQUEST = true;

void main() {
  HttpServer.bind(HOST, PORT).then((HttpServer server) {
    server.listen((HttpRequest request) {
      var response = request.response;
      response.done.then((d) {
        log("sent response to the client for request ${request.uri}");
      }).catchError((e) {
        log("Error occured while sending response: $e");
      });
      // write request handler code using tri-catch block
      requestHandler(request);
    });
    log("Serving on http://${HOST}:${PORT}.");
  });
}

log(String msg) {
  if (LOG_REQUEST) {
    print("${new DateTime.now().toString().substring(11)} : $msg");
  }
}

requestHandler(HttpRequest request) {
  try {
    var response = request.response;
    if (request.uri.path == "/") {
      // following line raises an exception
//        throw Exception('exception raised within the requestHandler');
      // following lines creates content length mismatch
      response.contentLength = 10;
      // following lines return a future completed even if the file is not found
//        var file = File('http_servers/resources/test_data_2.txt');
      var file = File('http_servers/resources/test_data_2.txt');
      file.openRead().pipe(response).catchError((e) {
        log("Error occured while writing the file: $e");
        response.close();
      });
    } else
      response.close();
  } catch (err, st) {
    log("Server Error : $err \n $st");
    request.response
      ..write('500 Internal Server Error')
      ..close();
  }
}

