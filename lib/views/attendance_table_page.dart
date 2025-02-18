import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qacc_application/models/app_colors.dart';

@RoutePage()
class AttendanceTablePage extends StatefulWidget {
  final int employeeID;
  const AttendanceTablePage({Key? key, required this.employeeID}) : super(key: key);

  @override
  _AttendanceTablePageState createState() => _AttendanceTablePageState();
}

class _AttendanceTablePageState extends State<AttendanceTablePage> {
  late Future<List<dynamic>> futureAttendance;

  @override
  void initState() {
    super.initState();
    futureAttendance = fetchAttendance(widget.employeeID);
  }

  // دالة لجلب بيانات الحضور والانصراف من API
  Future<List<dynamic>> fetchAttendance(int employeeID) async {
    // تأكد من تعديل الرابط ليناسب موقع ملف attendance_api.php على السيرفر
    final response = await http.get(Uri.parse('https://hr.qacc.ly/php/attendance_api.php?employeeID=$employeeID'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('فشل جلب بيانات الحضور');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: Icon(
            Icons.arrow_circle_left_rounded,
            color: AppColors.white,
            size: 40.0,
          ),
        ),
        title: const Text('سجل الحضور والانصراف'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder<List<dynamic>>(
          future: futureAttendance,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final attendanceList = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical, // تمرير عمودي
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // تمرير أفقي
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('الرقم')),
                      DataColumn(label: Text('التاريخ')),
                      DataColumn(label: Text('الوقت')),
                    ],
                    rows: List<DataRow>.generate(
                      attendanceList.length,
                      (index) {
                        final attendance = attendanceList[index];
                        return DataRow(
                          cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text('${attendance['authDate']}')),
                            DataCell(Text('${attendance['authTime']}')),
                          ],
                        );
                      },
                    ),
                  ),
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
    );
  }
}
