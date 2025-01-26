import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = Color(0xFFF5F5F5); // لون الخلفية

  static const Color textColor = Color(0xFF000000); // لون النص
  static const Color appBarColor = Color(0xFF313030);
  static const Color white = Color(0xFFFFFFFF); // لون الخلفية

  static MaterialColor primaryColor =
      const MaterialColor(0xFFDAB74C, <int, Color>{
    50: Color(0xfffff9e0c0),
    100: Color(0xfffff3c280),
    200: Color(0xffffeab360),
    300: Color(0xffffe09150),
    400: Color(0xFFE3B016),
    500: Color(0xffffdab74c),
    600: Color(0xFFCAAD3A),
    700: Color(0xFFB09230),
    800: Color(0xFFA08128),
    900: Color(0xFF906020),
  });

  static MaterialColor secondaryColor =
      const MaterialColor(0xFF5D5C59, <int, Color>{
    50: Color(0xFFF3F3F3), // لون فاتح جدًا
    100: Color(0xFFE5E5E5), // لون أفتح
    200: Color(0xFFCAC8C6), // لون خفيف
    300: Color(0xFFB4B2B0), // متوسط الفاتحية
    400: Color(0xFF9E9C99), // أقرب إلى اللون الأساسي
    500: Color(0xFF5D5C59), // اللون الأساسي
    600: Color(0xFF4E4D4A), // أغمق قليلًا
    700: Color(0xFF3F3E3C), // أغمق بدرجة
    800: Color(0xFF302F2E), // غامق أكثر
    900: Color(0xFF212120), // غامق جدًا
  }); // لون النص
}
