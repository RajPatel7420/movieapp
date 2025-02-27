import 'package:intl/intl.dart';

class Utils {
  Utils._();

  static String formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date; // Return original if parsing fails
    }
  }
}