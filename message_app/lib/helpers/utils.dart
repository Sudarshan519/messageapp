import 'package:intl/intl.dart';

String getFormattedTime(int mills) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(mills);
  String format = "hh:mm aa";
  var a = DateFormat(format).format(dateTime).toString();
  return a;
}
