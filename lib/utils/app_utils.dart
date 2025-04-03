/*
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AppUtils {
  /// TODO 00:00 format
  static String formatSeconds(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  static String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'goodMorning'.tr();
    } else if (hour >= 12 && hour < 17) {
      return 'goodAfternoon'.tr();
    } else {
      return 'goodEvening'.tr();
    }
  }

  /// TODO hh:mm a format
  static String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    return DateFormat('hh:mm a').format(dateTime);
  }

  /// TODO d MMM yyyy format
  static String formatDate(String dateTimeString) {
    DateTime dateTime =
        DateTime.parse(dateTimeString).toLocal(); // Convert to local time
    return DateFormat('d MMM yyyy').format(dateTime);
  }

  String getRelativeDateFormat(String utcDateString) {
    // Parse the UTC date string
    DateTime localDate = DateTime.parse(utcDateString).toUtc().toLocal();

    // Extract only the date part (ignore time)
    DateTime localDateOnly = DateTime(
      localDate.year,
      localDate.month,
      localDate.day,
    );

    // Get today and yesterday in local timezone (ignoring time)
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    if (localDateOnly.isAtSameMomentAs(today)) {
      return "Today";
    } else if (localDateOnly.isAtSameMomentAs(yesterday)) {
      return "Yesterday";
    } else {
      return DateFormat(
        'dd MMMM yyyy',
      ).format(localDateOnly); // Example: "30 Mar, 2025"
    }
  }

  String getRelativeTimeFormat(String utcDateString) {
    // Parse the UTC date string and convert to local time
    DateTime localDate = DateTime.parse(utcDateString).toLocal();

    // Get current time and dates
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Get only the date part (ignore time)
    DateTime localDateOnly = DateTime(
      localDate.year,
      localDate.month,
      localDate.day,
    );

    if (localDateOnly.isAtSameMomentAs(today)) {
      // Calculate difference in hours and minutes
      Duration difference = now.difference(localDate);
      if (difference.inMinutes < 1) {
        return "Just now";
      } else if (difference.inHours < 1) {
        return "${difference.inMinutes} min ago";
      } else {
        return "${difference.inHours} hours ago";
      }
    } else {
      return DateFormat('hh:mm').format(localDate); // Example: "10:30 AM"
    }
  }

  Future downloadFile(String url, String filename) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final file = File('${directory.path}/$filename');
        return file.writeAsBytes(response.bodyBytes);
      } else {
        throw Exception('Failed to load file');
      }
    } catch (e) {
      throw Exception('Error downloading file: $e');
    }
  }
}
*/
