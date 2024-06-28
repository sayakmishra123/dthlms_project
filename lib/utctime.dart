import 'package:intl/intl.dart';

class UtcTime {
  late DateTime utcTime = DateTime.now();
  String formattedDate = '';

  String utctime() {
    formattedDate = DateFormat('dd MMM yyyy hh:mm a').format(utcTime);
    return formattedDate;
  }
}
