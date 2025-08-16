import 'package:flutter/material.dart';

class AppDateUtils {
  // Private constructor to prevent instantiation
  AppDateUtils._();

  // These constants are kept for potential future use with date formatting libraries
  // static const String _apiDateFormat = 'yyyy-MM-dd';
  // static const String _displayDateFormat = 'dd/MM/yyyy';

  /// Format DateTime for API communication (ISO 8601: YYYY-MM-DD)
  static String formatForApi(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
           '${date.month.toString().padLeft(2, '0')}-'
           '${date.day.toString().padLeft(2, '0')}';
  }

  /// Format DateTime for user display (DD/MM/YYYY)
  static String formatForDisplay(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/'
           '${date.month.toString().padLeft(2, '0')}/'
           '${date.year}';
  }

  /// Parse date string from API response
  static DateTime? parseFromApi(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    
    try {
      // Handle both ISO format (YYYY-MM-DD) and full DateTime format
      if (dateString.contains('T')) {
        // Full DateTime format: 2023-12-25T10:30:00Z
        return DateTime.parse(dateString);
      } else {
        // Date only format: 2023-12-25
        final parts = dateString.split('-');
        if (parts.length == 3) {
          final year = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final day = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
      }
    } catch (e) {
      debugPrint('Error parsing date: $dateString - $e');
    }
    return null;
  }

  /// Parse date from user input (DD/MM/YYYY)
  static DateTime? parseFromDisplay(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    
    try {
      final parts = dateString.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      debugPrint('Error parsing display date: $dateString - $e');
    }
    return null;
  }

  /// Check if a date is in the past (before today)
  static bool isPastDate(DateTime date) {
    final today = DateTime.now();
    final dateOnly = DateTime(date.year, date.month, date.day);
    final todayOnly = DateTime(today.year, today.month, today.day);
    return dateOnly.isBefore(todayOnly);
  }

  /// Check if a date is within reasonable age limits for date of birth
  static bool isReasonableAge(DateTime date) {
    final now = DateTime.now();
    final age = now.year - date.year;
    
    // Reasonable age limits: between 0 and 150 years old
    return age >= 0 && age <= 150;
  }

  /// Validate date of birth
  static String? validateDateOfBirth(DateTime? date) {
    if (date == null) {
      return null; // Allow null (optional field)
    }

    if (!isPastDate(date)) {
      return 'Date of birth must be in the past';
    }

    if (!isReasonableAge(date)) {
      return 'Please enter a valid date of birth';
    }

    return null; // Valid date
  }

  /// Get age from date of birth
  static int? getAge(DateTime? dateOfBirth) {
    if (dateOfBirth == null) return null;
    
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    
    // Check if birthday hasn't occurred this year yet
    if (now.month < dateOfBirth.month || 
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    
    return age;
  }

  /// Get the earliest selectable date (150 years ago)
  static DateTime getEarliestSelectableDate() {
    final now = DateTime.now();
    return DateTime(now.year - 150, now.month, now.day);
  }

  /// Get the latest selectable date (yesterday)
  static DateTime getLatestSelectableDate() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day - 1);
  }

  /// Show Material date picker with proper constraints
  static Future<DateTime?> showDateOfBirthPicker(BuildContext context, {
    DateTime? initialDate,
  }) async {
    final now = DateTime.now();
    final earliestDate = getEarliestSelectableDate();
    final latestDate = getLatestSelectableDate();
    
    // If initialDate is null or invalid, use a reasonable default (25 years ago)
    DateTime defaultDate = initialDate ?? DateTime(now.year - 25, now.month, now.day);
    
    // Ensure default date is within bounds
    if (defaultDate.isAfter(latestDate)) {
      defaultDate = latestDate;
    } else if (defaultDate.isBefore(earliestDate)) {
      defaultDate = earliestDate;
    }

    return await showDatePicker(
      context: context,
      initialDate: defaultDate,
      firstDate: earliestDate,
      lastDate: latestDate,
      helpText: 'Select Date of Birth',
      cancelText: 'Cancel',
      confirmText: 'Select',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  /// Format date for accessibility (screen readers)
  static String formatForAccessibility(DateTime? date) {
    if (date == null) return 'No date selected';
    
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  /// Check if two dates are the same day
  static bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year && 
           date1.month == date2.month && 
           date1.day == date2.day;
  }
}