//import 'dart:async';
import 'dart:io';
import 'package:logging/logging.dart';
//import 'package:test/test.dart';

// create logger
final log = Logger('MyClass');

createLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print(
        '${rec.level.name}: ${rec.time.toString().substring(11)} : ${rec.message}');
  });
}

// doSomethingAsync
doSomethingAsync() async {
  var file = new File('bin/logging_test1.txt');
  return file.readAsStringSync();
}

// main()
main() async {
  createLogger();
  log.fine('started processes');
  var future = doSomethingAsync().then((result) {
    log.fine('Got the result: $result');
  }).catchError((e, stackTrace) => log.severe('Oh noes!', e, stackTrace));
}
