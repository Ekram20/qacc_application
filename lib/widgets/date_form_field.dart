import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';

class DateFormField extends StatelessWidget {
  final TextEditingController controller;
  final DateTime? initialDate;
  final ValueChanged<DateTime?> onDateSelected;
  final String? Function(String?)? validator;

  DateFormField({
    required this.controller,
    required this.onDateSelected,
    this.initialDate,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      style: Theme.of(context).textTheme.bodyMedium,
      // تخصيص تنسيق النص

      decoration: InputDecoration(
        labelText: 'تاريخ التكليف',
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_today),
        fillColor: AppColors.secondaryColor.shade50,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryColor.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryColor.shade600),
        ),
      ),
      validator: validator,
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (date == null) return;
        onDateSelected(date); // استدعاء دالة العودة مع التاريخ الجديد
      },
    );
  }
}
