import 'dart:io';

main() {
  print('ファイル読み出し開始');
  var file = new File('major_libraries/test_data.txt');
  var contents = file.readAsStringSync(); // プログラムは総ての内容が読み出されるまでブロックされてしまう
  print(contents);
  print('読み出し完了');
}
