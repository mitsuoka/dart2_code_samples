import 'dart:io';

main() async {
  print('ファイル読み出し開始');
  var file = new File('major_libraries/test_data.txt');
  var contents = await file.readAsString(); // この間他のイベントに対応できる
  print(contents);
  print('読み出し完了');
}
