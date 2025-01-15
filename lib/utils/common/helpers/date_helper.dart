import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static String getFormattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static int daysBetween(DateTime from, DateTime to) {
    final difference = to.difference(from).inDays;
    return difference;
  }
}
