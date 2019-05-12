import 'dart:io';

main() {
  print('ファイル読み出し開始');
  var file = new File('major_libraries/test_data.txt');
  file.readAsString().then((String contents) {
    print(contents); // ファイルが読みだされたときに出力
    print('読み出し完了');
  });
  // その間他の処理やイベントにも対応できる
}
