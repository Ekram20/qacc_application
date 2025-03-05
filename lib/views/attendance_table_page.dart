import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qacc_application/models/app_colors.dart';

import '../widgets/section_header.dart';

@RoutePage()
class AttendanceTablePage extends StatefulWidget {
  final int employeeID;
  const AttendanceTablePage({Key? key, required this.employeeID}) : super(key: key);

  @override
  _AttendanceTablePageState createState() => _AttendanceTablePageState();
}

class _AttendanceTablePageState extends State<AttendanceTablePage> {
  late Stream<List<dynamic>> attendanceStream;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  List<dynamic> filteredAttendance = [];

  @override
  void initState() {
    super.initState();
    attendanceStream = getAttendanceStream(widget.employeeID);
  }

  // دالة لجلب بيانات الحضور كـ Stream
  Stream<List<dynamic>> getAttendanceStream(int employeeID) async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse('https://hr.qacc.ly/php/attendance_api.php?employeeID=$employeeID'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          filterAttendanceByDate(data);
          yield filteredAttendance;
        } else {
          throw Exception('فشل جلب بيانات الحضور');
        }
      } catch (e) {
        yield [];
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  // دالة لتصفية البيانات حسب التاريخ المدخل (باستخدام النص في حقول التاريخ)
  void filterAttendanceByDate(List<dynamic> attendanceData) {
    setState(() {
      String startDate = startDateController.text;
      String endDate = endDateController.text;

      if (startDate.isEmpty && endDate.isEmpty) {
        filteredAttendance = attendanceData;
      } else {
        filteredAttendance = attendanceData.where((attendance) {
          String authDate = attendance['authDate'] ?? '';
          bool afterStartDate = startDate.isEmpty || authDate.compareTo(startDate) >= 0;
          bool beforeEndDate = endDate.isEmpty || authDate.compareTo(endDate) <= 0;
          return afterStartDate && beforeEndDate;
        }).toList();
      }
    });
  }

  // دالة لتحديد لون الوقت بناءً على قواعد الحضور والانصراف
  Color getAttendanceColor(String time) {
    try {
      final attendanceTime = TimeOfDay(
        hour: int.parse(time.split(":")[0]),
        minute: int.parse(time.split(":")[1]),
      );

      if (attendanceTime.hour < 9 || (attendanceTime.hour == 9 && attendanceTime.minute <= 30)) {
        return Colors.black;
      } else if (attendanceTime.hour >= 9 && attendanceTime.minute > 30) {
        return Colors.red;
      } else if (attendanceTime.hour < 14 || (attendanceTime.hour == 14 && attendanceTime.minute < 30)) {
        return Colors.red;
      } else {
        return Colors.black;
      }
    } catch (e) {
      return Colors.black;
    }
  }

  // دالة لاختيار التاريخ باستخدام showDatePicker
  Future<void> _selectDate(BuildContext context, TextEditingController controller, {required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
      filterAttendanceByDate(filteredAttendance);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_circle_left_rounded,
            color: AppColors.white,
            size: 40.0,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            const Gap(20),
            const SectionHeader(title: 'سجلات الحضور والإنصراف'),
            const Gap(20),
            // حقول التاريخ بتصميم مشابه للنمط المطلوب
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: startDateController,
                      readOnly: true,
                      onTap: () => _selectDate(context, startDateController, isStartDate: true),
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        labelText: 'تاريخ البداية',
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.calendar_today),
                        fillColor: AppColors.secondaryColor.shade50,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondaryColor.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondaryColor.shade600),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: endDateController,
                      readOnly: true,
                      onTap: () => _selectDate(context, endDateController, isStartDate: false),
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        labelText: 'تاريخ النهاية',
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.calendar_today),
                        fillColor: AppColors.secondaryColor.shade50,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondaryColor.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondaryColor.shade600),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // عرض الجدول مع بيانات الحضور بشكل flex ومتجاوب مع الاتجاهين
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                stream: attendanceStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final attendanceList = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: constraints.maxWidth,
                                  // يمكن تعديل minHeight إذا رغبت
                                ),
                                child: DataTable(
                                  columnSpacing: 30.0,
                                  headingRowHeight: 50,
                                  dataRowHeight: 45,
                                  columns: const [
                                    DataColumn(
                                      label: Expanded(
                                        child: Center(
                                          child: Text('الرقم', textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Center(
                                          child: Text('التاريخ', textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Center(
                                          child: Text('الوقت', textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: List<DataRow>.generate(
                                    filteredAttendance.isNotEmpty ? filteredAttendance.length : attendanceList.length,
                                        (index) {
                                      final attendance = filteredAttendance.isNotEmpty
                                          ? filteredAttendance[index]
                                          : attendanceList[index];
                                      final String authTime = attendance['authTime'] ?? '00:00';
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            Center(
                                              child: Text(
                                                '${index + 1}',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text(
                                                '${attendance['authDate']}',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text(
                                                authTime,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(color: getAttendanceColor(authTime)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
