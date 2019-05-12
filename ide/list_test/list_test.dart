import 'dart:math';

main() {
  List myList = ['pi is ', pi, ', and cos pi is ', cos(pi)];
  String s = '';
  for (int i = 0; i < myList.length; i++) {
    s = "$s${myList[i].toString()}";
  }
  print(s);
}
/*
pi is 3.141592653589793, and cos pi is -1
*/
