import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String toTitleCase() {
    if (isEmpty) {
      return this;
    }

    return split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  String toISODate() {
    DateTime dateTime = DateTime.parse(this);
    DateFormat dateFormat = DateFormat("yyyy/MM/dd");
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  String toTimeAgo() {
    try {
      DateTime dateTime = DateTime.parse(this);
      String timeAgo = timeago.format(dateTime, allowFromNow: true);

      return timeAgo;
    } on Exception catch (_) {
      return this;
    }
  }

  String toCommentDate() {
    // Parse the date string to a DateTime object
    DateTime dateTime = DateTime.parse(this);

    // Get the current year
    int currentYear = DateTime.now().year;

    // Format the date to "May 16" or "2023 May 16"
    if (dateTime.year == currentYear) {
      return DateFormat('MMMM d').format(dateTime);
    } else {
      return DateFormat('yyyy MMMM d').format(dateTime);
    }
  }

  String toTime() {
    DateTime dateTime = DateTime.parse(this);

    // Format the DateTime object to the desired time format (HH:mm)
    String formattedTime = DateFormat('HH:mm').format(dateTime);

    return formattedTime;
  }
}

extension OptionalStringExtension on String? {
  bool get isNotNullAndEmpty {
    return this != null && this!.isNotEmpty;
  }
}
