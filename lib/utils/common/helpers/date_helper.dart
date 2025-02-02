import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static String formatDate(DateTime date) {
    final day = DateFormat('d').format(date);
    final suffix = getDaySuffix(int.parse(day));
    final month = DateFormat('MMMM').format(date);
    final year = DateFormat('y').format(date);
    return '$day$suffix $month $year';
  }
}
