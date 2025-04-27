import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/views/leave_request_details_screen.dart';
import 'package:qacc_application/widgets/circularProgressIndicator.dart';
import 'package:qacc_application/widgets/section_header.dart';

@RoutePage()

class HigherManagerLeavesApproval extends StatefulWidget {
  const HigherManagerLeavesApproval({super.key});

  @override
  State<HigherManagerLeavesApproval> createState() => _HigherManagerLeavesApprovalState();
}

class _HigherManagerLeavesApprovalState extends State<HigherManagerLeavesApproval> {

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

/* 
  Future<List<dynamic>> fetchRequests() async {
    final response = await http.get(Uri.parse(
        'https://hr.qacc.ly/php/get_direct_manager_leaves_requests.php?manager_id=$employeeId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("فشل في تحميل الطلبات");
    }
  }
 */
  Future<void> fetchRequests() async {
    final url = Uri.parse(
        "https://hr.qacc.ly/php/get_higher_manager_requests.php?manager_id=$employeeId");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          requests = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        print('فشل في تحميل الطلبات');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("خطأ أثناء جلب الطلبات: $e");
    }
  }

  Future<void> updateDirectManagerApproval(int leaveId, String status) async {
    final url =
        Uri.parse("https://hr.qacc.ly/php/update_higher_manager_approval.php");
    try {
      final response = await http.post(
        url,
        body: {
          'leave_id': leaveId.toString(),
          'status': status,
        },
      );

      final responseData = json.decode(response.body);
      if (responseData['success']) {
        fetchRequests(); // إعادة التحديث
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "تم تحديث حالة الطلب",
              textAlign: TextAlign.right,
            ),
            backgroundColor: const Color.fromARGB(255, 50, 50, 50),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'فشل في التحديث')),
        );
      }
    } catch (e) {
      print("خطأ في التحديث: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ أثناء التحديث")),
      );
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
                        SectionHeader(title: 'الإجازات التي قمت بطلبها'),
                        Gap(10.0),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            final request = requests[index];
                            final leaveId = request["id"];
                            final status = request["higher_manager_approval"];
                            final isApproved = status == "مقبول";
                            final isRejected = status == "مرفوض";
                            final isPending =
                                !isApproved && !isRejected;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Card(
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
                                        'اسم الموظف: ${request["employee_name"]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      Gap(10.0),
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

                                      // زر القبول
                                      Container(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: isApproved
                                                ? Colors.grey
                                                : Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: isPending
                                              ? () async {
                                                  await updateDirectManagerApproval(
                                                      leaveId, "مقبول");
                                                }
                                              : null,
                                          child: Text(
                                            isApproved
                                                ? ' تم قبول طلب الإجازة'
                                                : 'قبول طلب الإجازة',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Gap(10.0),

                                      // صف التفاصيل والرفض
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueGrey,
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
                                          Gap(10.0),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: isRejected
                                                  ? Colors.grey
                                                  : Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: isPending
                                                ? () async {
                                                    await updateDirectManagerApproval(
                                                        leaveId, "مرفوض");
                                                  }
                                                : null,
                                            child: Text(
                                              isRejected
                                                  ? 'تم الرفض'
                                                  : 'رفض',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ),
                                        ],
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
