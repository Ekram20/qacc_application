import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier {
  Map<String, dynamic>? _employeeData;

  Map<String, dynamic>? get employeeData => _employeeData;

  void setEmployeeData(Map<String, dynamic> data) {
    _employeeData = data;
    notifyListeners(); // تحديث الواجهة عند تغيير البيانات
  }

  void clearEmployeeData() {
    _employeeData = null;
    notifyListeners();
  }
}
