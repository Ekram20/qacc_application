import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';

class DateFormField extends StatelessWidget {
  final TextEditingController controller;
  final DateTime? initialDate;
  final ValueChanged<DateTime?> onDateSelected;
  final String? Function(String?)? validator;
  final String labelText; // إضافة متغير لنص الحقل
  final bool readOnly; // خاصية جديدة

  DateFormField({
    required this.controller,
    required this.onDateSelected,
    this.initialDate,
    this.validator,
    required this.labelText,
    this.readOnly = false, // إضافة خاصية readOnly مع قيمة افتراضية
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      style: Theme.of(context).textTheme.bodyMedium,
      // تخصيص تنسيق النص

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
