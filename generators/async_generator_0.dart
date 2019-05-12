Stream gen(log) async* {
  await for (int k in new Stream.fromIterable([1, 2, 3, 4, 5])) {
    addLog('s' + k.toString());
    if (k <= 5) {
      // そのkに対する必要な処理を非同期で行う
      // 例えば時間がかかるFobonacci関数を計算
      fib(30);
      yield k.toString();
    }
    addLog('f' + k.toString());
  }
}

List log = [];

addLog(value) {
  log.add(new DateTime.now().toString().substring(11) + ', value: $value');
}

printLog() {
  log.forEach(print);
}

// Fibonacci：時間がかかる関数
int fib(int i) {
  if (i < 2) return i;
  return fib(i - 2) + fib(i - 1);
}

main() {
  gen(log).listen((_) {},
      onError: (err) => addLog("An error occured: $err"),
      onDone: () {
        addLog("The stream was closed");
        printLog();
      });
  addLog('reached to the end of the main()');
}
