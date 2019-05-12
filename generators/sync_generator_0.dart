List log = [];
addLog(value) {
  log.add(new DateTime.now().toString().substring(11) + ', value: $value');
}

// sync*関数はIterableを返す
Iterable<int> evenNumbersDownFrom(int n) sync* {
  // このボディはiterator（この例ではforEachメソッドで）がmoveNext()を呼び出すまで実行されない
  while (n >= 0) {
    if (n % 2 == 0) {
      // 'yield' はこの関数を保留にする
      yield n;
    }
    n--;
  }

  // この関数の最後が実行されたら、
  // Iterableの中にはもう値は存在せず、
  // moveNext()は呼び出し側にfalseを返す
}

main() {
  evenNumbersDownFrom(7).forEach(addLog);
  log.forEach(print);
}