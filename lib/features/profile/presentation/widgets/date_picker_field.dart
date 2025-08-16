import 'package:flutter/material.dart';
import '../../../../core/utils/date_utils.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;
  final String label;
  final IconData icon;
  final bool enabled;
  final String? Function(DateTime?)? validator;
  final String? errorText;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.label,
    this.icon = Icons.calendar_today_outlined,
    this.enabled = true,
    this.validator,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Validate the current date
    final validationError = validator?.call(selectedDate) ?? errorText;
    final hasError = validationError != null;

    return InkWell(
      onTap: enabled ? () => _showDatePicker(context) : null,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
          prefixIcon: Icon(icon, color: colorScheme.primary),
          filled: true,
          fillColor: enabled
              ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
              : colorScheme.surfaceContainerHighest.withValues(alpha: 0.15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: hasError 
                ? colorScheme.error
                : colorScheme.outline.withValues(alpha: 0.4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.error, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.error, width: 2),
          ),
          errorText: hasError ? validationError : null,
          suffixIcon: enabled
              ? Icon(
                  Icons.arrow_drop_down,
                  color: hasError
                      ? colorScheme.error
                      : colorScheme.onSurfaceVariant,
                )
              : null,
        ),
        child: Text(
          selectedDate != null
              ? AppDateUtils.formatForDisplay(selectedDate)
              : '',
          style: TextStyle(
            color: selectedDate != null
                ? (enabled 
                    ? colorScheme.onSurface 
                    : colorScheme.onSurface.withValues(alpha: 0.6))
                : colorScheme.onSurface.withValues(alpha: 0.38),
          ),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    try {
      final selectedDate = await AppDateUtils.showDateOfBirthPicker(
        context,
        initialDate: this.selectedDate,
      );
      
      if (selectedDate != null) {
        onDateSelected(selectedDate);
      }
    } catch (e) {
      debugPrint('Error showing date picker: $e');
      
      // Show error snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unable to open date picker. Please try again.'),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}

/// A form field wrapper for DatePickerField that integrates with Flutter forms
class DatePickerFormField extends FormField<DateTime> {
  DatePickerFormField({
    super.key,
    super.initialValue,
    required ValueChanged<DateTime?> onDateSelected,
    required String label,
    IconData icon = Icons.calendar_today_outlined,
    super.enabled = true,
    super.validator,
    super.autovalidateMode,
  }) : super(
          builder: (FormFieldState<DateTime> state) {
            return DatePickerField(
              selectedDate: state.value,
              onDateSelected: (date) {
                state.didChange(date);
                onDateSelected(date);
              },
              label: label,
              icon: icon,
              enabled: state.widget.enabled,
              validator: state.widget.validator,
              errorText: state.errorText,
            );
          },
        );
}