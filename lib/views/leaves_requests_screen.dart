import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/views/leave_request_details_screen.dart';
import 'package:qacc_application/widgets/circularProgressIndicator.dart';
import 'package:qacc_application/widgets/section_header.dart';

@RoutePage()
class LeavesRequestsScreen extends StatefulWidget {
  const LeavesRequestsScreen({super.key});

  @override
  State<LeavesRequestsScreen> createState() => _LeavesRequestsScreenState();
}

class _LeavesRequestsScreenState extends State<LeavesRequestsScreen> {
  late int employeeId; // يجب تمرير employeeId من تسجيل الدخول
  List<dynamic> requests = [];
  bool _isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    employeeId = Provider.of<EmployeeProvider>(context, listen: false)
        .employeeData!["id"];
    fetchRequests();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      fetchRequests();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchRequests() async {
    try {
      final url = Uri.parse(
          'https://hr.qacc.ly/php/get_employee_leaves_requests.php?employee_id=$employeeId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> newRequests = json.decode(response.body);

        if (!listEquals(newRequests, requests)) {
          setState(() {
            requests = newRequests;
          });
        }
      } else {
        throw Exception('فشل في تحميل الرسائل');
      }
    } catch (error) {
      print('خطأ أثناء جلب البيانات: $error');
    } finally {
      if (_isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
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
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: _isLoading
            ? Center(child: CustomLoadingIndicator())
            : requests.isEmpty
                ? Center(child: Text('لا توجد طلبات متاحة'))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20),
                        SectionHeader(
                          title: 'الإجازات التي قمت بطلبها',
                        ),
                        Gap(10.0),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            final request = requests[index];
                            return Padding(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 8.0),
                              child: Card(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: AppColors.secondaryColor.shade300,
                                      width: 1.5),
                                ),
                                color: Color.fromARGB(255, 249, 249, 249),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'نوع الطلب: ${request["leave_type"]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      Gap(10.0),
                                      Text(
                                        'حالة الطلب: ${request["status"]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      Gap(10.0),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LeaveRequestDetailsScreen(
                                                        request: request),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'التفاصيل',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
