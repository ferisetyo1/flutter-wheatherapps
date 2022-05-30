import 'package:intl/intl.dart';
extension DateTimeExtension on DateTime{
  toFormatedDate(String format){
    var fm = DateFormat(format);
    return fm.format(this);
  }
}