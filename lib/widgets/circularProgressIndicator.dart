import 'package:flutter/material.dart';


import '../models/app_colors.dart'; // تأكد من استيراد ملف الألوان الخاص بك

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CircularProgressIndicator(
      color: AppColors.primaryColor,
    );
  }
}
