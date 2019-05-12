import 'package:timeago/timeago.dart' as timeago;
import 'dart:html';

main() {
  // Add a new locale messages
  timeago.setLocaleMessages('ja', timeago.JaMessages());
  // See if Dart is running
  var mesArea = document.getElementById('title');
  mesArea.innerHtml = 'dart code started';
  // Go button listening forever
  var goButton = document.getElementById('goTimeago');
  // On click event handler
  goButton.onClick.listen((e) {
    var el, p;
    el = document.getElementById('epochYear') as SelectElement;
    var epochYear = el.value;
    el = document.getElementById('epochMonth') as SelectElement;
    p = ('0' + el.value);
    var epochMonth = p.substring(p.length - 2);
    el = document.getElementById('epochDay') as SelectElement;
    p = ('0' + el.value);
    var epochDay = p.substring(p.length - 2);
    var tstr = '$epochYear-$epochMonth-${epochDay}T12:00';
    var epochDateTime = DateTime.parse(tstr);
    var currentDateTime = DateTime.now();
    var agoDateTime = currentDateTime.difference(epochDateTime);
    print('  epoch time is :  ${epochDateTime.toIso8601String()}');
    print('current time is :  ${currentDateTime.toIso8601String()}');
    print('    duration is :  ${agoDateTime}');
    print('duration_inDays :  ${agoDateTime.inDays}');
    print('duration_inHours:  ${agoDateTime.inHours}');
    document.getElementById('timeAgo1').innerHtml = "<br>"
        "<br>current time is : ${currentDateTime.toIso8601String()}"
        "<br>epoch time is   : ${epochDateTime.toIso8601String()}"
        "<br>inDays :  ${agoDateTime.inDays}"
        "<br>inHours : ${agoDateTime.inHours}";
    var timeagoResult =
        timeago.format(epochDateTime, locale: 'ja', allowFromNow: true);
    print('datetime_output :  $timeagoResult');
    document.getElementById('timeAgo2').innerHtml = "<br> $timeagoResult";
  });
}
