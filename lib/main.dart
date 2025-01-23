import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: '',
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 20,
            color: AppColors.secondaryColor.shade900,
            fontFamily: 'Cairo',
          ),
          headlineMedium: TextStyle(
            fontSize: 18,
            color: AppColors.secondaryColor.shade500,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: TextStyle(
            fontSize: 16,
            color: AppColors.secondaryColor.shade500,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            color: AppColors.secondaryColor.shade900,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ), // نص كبير
          bodyMedium: TextStyle(
            fontSize: 16,
            color: AppColors.secondaryColor.shade500,
            fontFamily: 'Cairo',
          ), // نص متوسط
          bodySmall: TextStyle(
            fontSize: 16,
            color: AppColors.white,
            fontFamily: 'Cairo',
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appBarColor, // لون شريط التطبيق
          elevation: 0, // إخفاء الظل
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: AppColors.white, // لون خلفية القائمة
          textStyle:
              TextStyle(color: AppColors.textColor), // لون النصوص داخل القائمة
        ),
      ),
      routerConfig: appRouter.config(),
    );
  }
}
