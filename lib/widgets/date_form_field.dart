import 'package:flutter/material.dart';

import '../models/app_colors.dart';

class DateFormField extends StatelessWidget {
  final TextEditingController controller;
  final DateTime? initialDate;
  final ValueChanged<DateTime?> onDateSelected;
  final String? Function(String?)? validator;
  final String labelText;
  final bool readOnly;

  DateFormField({
    required this.controller,
    required this.onDateSelected,
    this.initialDate,
    this.validator,
    required this.labelText,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: labelText,
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
      validator: validator, // إضافة التحقق هنا
      onTap: () async {
        if (readOnly) return; // تخطي النقر إذا كان الحقل للقراءة فقط
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (date == null) return;
        onDateSelected(date);
      },
    );
  }
}
