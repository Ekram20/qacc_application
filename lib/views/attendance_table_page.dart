import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import '../providers/employee_provider.dart';
import '../widgets/circularProgressIndicator.dart';
import '../widgets/date_form_field.dart';
import '../widgets/section_header.dart';

@RoutePage()
class AttendanceTablePage extends StatefulWidget {

  const AttendanceTablePage({Key? key}) : super(key: key);

  @override
  _AttendanceTablePageState createState() => _AttendanceTablePageState();
}

class _AttendanceTablePageState extends State<AttendanceTablePage> {
  late Stream<List<dynamic>> attendanceStream;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  List<dynamic> filteredAttendance = [];
  late String employeeNumber ;
  @override
  void initState() {
    super.initState();
    final employeeData =
        Provider.of<EmployeeProvider>(context, listen: false).employeeData;


    employeeNumber = employeeData?["employee_number"] ?? "";
    attendanceStream = getAttendanceStream(employeeNumber);
  }

  // دالة لجلب بيانات الحضور كـ Stream
  Stream<List<dynamic>> getAttendanceStream(String employeeNumber) async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse('https://hr.qacc.ly/php/attendance_api.php?employeeID=$employeeNumber'));
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

  Color getAttendanceColor(String time) {
    try {
      final parts = time.split(":");
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      // إنشاء وقت للمقارنة
      final totalMinutes = hour * 60 + minute;

      // حدود المقارنة
      final checkInLimit = 9 * 60 + 30;     // 9:30 صباحًا = 570 دقيقة
      final checkOutLimit = 14 * 60 + 30;   // 2:30 مساءً = 870 دقيقة

      if (totalMinutes <= checkInLimit) {
        return Colors.black; // حضور منتظم أو مبكر
      } else if (totalMinutes < checkOutLimit) {
        return Colors.red;   // تأخير أو انصراف مبكر
      } else {
        return Colors.black; // انصراف منتظم أو متأخر
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
                    child: DateFormField(
                      controller: startDateController,
                      labelText: 'تاريخ البداية',
                      readOnly: false,
                      onDateSelected: (selectedDate) {
                        if (selectedDate != null) {
                          final formattedDate = formatDate(selectedDate);
                          startDateController.text = formattedDate;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DateFormField(
                      controller: endDateController,
                      labelText: 'تاريخ النهاية',
                      readOnly: false,
                      onDateSelected: (selectedDate) {
                        if (selectedDate != null) {
                          final formattedDate = formatDate(selectedDate);
                          endDateController.text = formattedDate;
                        }
                      },
                    ),
                  ),
                ],
              )


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
                                                style: TextStyle(color: getAttendanceColor(authTime),),
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
                    return const Center(child: CustomLoadingIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  // دالة لتنسيق التاريخ إلى 'yyyy-MM-dd'
  String formatDate(DateTime date) {
    final String year = date.year.toString();
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

}
