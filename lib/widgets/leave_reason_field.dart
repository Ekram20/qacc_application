import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';

class LeaveReasonField extends StatelessWidget {
  final TextEditingController controller;

  final Function(String)? onChanged; // لمعالجة النص المدخل
  final String? Function(String?)? validator; // للتحقق من صحة النص

  const LeaveReasonField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.start,
      maxLines: 3, // لجعل الحقل متعدد الأسطر
      decoration: InputDecoration(
        labelText: 'سبب الإجازة',
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        alignLabelWithHint: true, // لضبط محاذاة labelText
        border: OutlineInputBorder(),
        fillColor: AppColors.secondaryColor.shade50,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryColor.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryColor.shade600),
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium,

      onChanged: onChanged,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء إدخال سبب الإجازة';
            }
            return null;
          },
    );
  }
}
