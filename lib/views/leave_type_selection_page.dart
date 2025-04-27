import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/router/app_router.gr.dart';

import 'package:qacc_application/widgets/image_text_card.dart';
import 'package:qacc_application/widgets/section_header.dart';

@RoutePage()
class LeaveTypeSelectionPage extends StatefulWidget {
  const LeaveTypeSelectionPage({super.key});

  @override
  State<LeaveTypeSelectionPage> createState() => _LeaveTypeSelectionPageState();
}

class _LeaveTypeSelectionPageState extends State<LeaveTypeSelectionPage> {
  late int employeeId;

  @override
  void initState() {
    super.initState();

    employeeId = Provider.of<EmployeeProvider>(context, listen: false)
        .employeeData!["id"];
  }

  Future<bool> checkLeaveTaken(BuildContext context, String leaveType) async {
    final response = await http.post(
      Uri.parse('https://hr.qacc.ly/php/check_leave_taken.php'),
      body: {'employee_id': employeeId.toString(), 'leave_type': leaveType},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['taken']; // إرجاع true إذا كان الموظف قد أخذ الإجازة مسبقًا
    }
    return false;
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
          child: SingleChildScrollView(
            child: FadeInUp(
              duration: Duration(seconds: 1),
              child: Column(
                children: [
                  Gap(20),
                  SectionHeader(title: 'حدد نوع الإجازة'),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.router.push(AnnualLeaveRequest());
                                },
                                child: ImageTextCard(
                                    image: 'assets/images/Google_Calendar.png',
                                    mainText: 'إجازة سنوية'),
                              ),
                            ),
                            Gap(15),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.router.push(SickLeaveRequest());
                                },
                                child: ImageTextCard(
                                    image: 'assets/images/Fever.png',
                                    mainText: 'إجازة مرضية'),
                              ),
                            ),
                          ],
                        ),
                        Gap(15),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.router.push(EmergencyLeaveRequest());
                                },
                                child: ImageTextCard(
                                    image: 'assets/images/Siren.png',
                                    mainText: 'إجازة طارئة'),
                              ),
                            ),
                            Gap(15),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.router.push(MaternityLeaveRequest());
                                },
                                child: ImageTextCard(
                                    image: 'assets/images/UNICEF.png',
                                    mainText: 'إجازة أمومة'),
                              ),
                            ),
                          ],
                        ),
                        Gap(15),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  bool hasTakenLeave = await checkLeaveTaken(
                                      context, "اجازة الزواج");
                                  if (!hasTakenLeave) {
                                    context.router.push(MarriageLeaveRoute());
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                        "لا يمكنك التقديم لهذه الإجازة مرة أخرى",
                                        textAlign: TextAlign.right,
                                      )),
                                    );
                                  }
                                },
                                child: ImageTextCard(
                                    image: 'assets/images/Diamond_Ring.png',
                                    mainText: 'إجازة الزواج'),
                              ),
                            ),
                            Gap(15),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  bool hasTakenLeave = await checkLeaveTaken(
                                      context, "اجازة الوفاة");
                                  if (!hasTakenLeave) {
                                    context.router.push(DeathLeave());
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                        "لا يمكنك التقديم لهذه الإجازة مرة أخرى",
                                        textAlign: TextAlign.right,
                                      )),
                                    );
                                  }
                                },
                                child: ImageTextCard(
                                    image: 'assets/images/Paper.png',
                                    mainText: 'إجازة الوفاة'),
                              ),
                            ),
                          ],
                        ),
                        Gap(15),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  bool hasTakenLeave = await checkLeaveTaken(
                                      context, "اجازة الحج");
                                  if (!hasTakenLeave) {
                                    context.router.push(HajjLeave());
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                        "لا يمكنك التقديم لهذه الإجازة مرة أخرى",
                                        textAlign: TextAlign.right,
                                      )),
                                    );
                                  }
                                },
                                child: ImageTextCard(
                                    image: 'assets/images/Kaaba.png',
                                    mainText: 'إجازة الحج'),
                              ),
                            ),
                            Gap(15),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.router.push(ExamsLeave());
                                },
                                child: ImageTextCard(
                                    image: 'assets/images/Grades.png',
                                    mainText: 'إجازة الإمتحانات'),
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
