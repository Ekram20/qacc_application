import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/views/archives_admin_screen.dart';
import 'package:qacc_application/views/archives_screen.dart';
import 'package:qacc_application/views/employee_files.dart';
import 'package:qacc_application/views/home_page.dart';

@RoutePage()
class BottomNavigationBarEmployees extends StatefulWidget {
    final String email; // استقبال البريد الإلكتروني من تسجيل الدخول

  const BottomNavigationBarEmployees({super.key, required this.email});

  @override
  State<BottomNavigationBarEmployees> createState() =>
      _BottomNavigationBarEmployeesState();
}

class _BottomNavigationBarEmployeesState
    extends State<BottomNavigationBarEmployees> {
      
   late List _pageOptions = [
    HomePage(email: widget.email),
    ArchivesScreen(),
    ArchivesAdminScreen(),
    EmployeeFiles(),
  ];

  int selectedPage = 0;

  void _updateIndex(int value) {
    setState(() {
      selectedPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[selectedPage],
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl, // الأيقونة من اليسار لليمين

        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedPage,
          onTap: _updateIndex,
          selectedItemColor: AppColors.primaryColor.shade100,
          unselectedItemColor: AppColors.white, // اللون غير المحدد

          selectedLabelStyle: TextStyle(
            fontFamily: 'Cairo', // تعيين الخط
            color: AppColors.primaryColor.shade100, // تعيين اللون المحدد
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Cairo', // تعيين الخط للـ unselected
            color: AppColors.white, // تعيين اللون للـ unselected
          ),
          backgroundColor: AppColors.appBarColor, // تغيير لون الخلفية

          selectedFontSize: 13,
          unselectedFontSize: 13,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              label: "الصفحة الرئيسية",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "المحفوظات",
              icon: Icon(Icons.archive),
            ),
            BottomNavigationBarItem(
              label: "بريد المدير العام",
              icon: Icon(Icons.business_center),
            ),
            BottomNavigationBarItem(
              label: "الملف المعني",
              icon: Icon(Icons.account_box),
            ),
          ],
        ),
      ),
    );
  }
}
