import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.icon,
    required this.validator,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  final String labelText;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
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
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
