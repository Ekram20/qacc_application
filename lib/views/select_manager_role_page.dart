import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/router/app_router.gr.dart';
import 'package:qacc_application/widgets/circularProgressIndicator.dart';
import 'package:qacc_application/widgets/image_text_card.dart';
import 'package:qacc_application/widgets/section_header.dart';

@RoutePage()
class SelectManagerRolePage extends StatefulWidget {
  const SelectManagerRolePage({super.key});

  @override
  State<SelectManagerRolePage> createState() => _SelectManagerRolePageState();
}

class _SelectManagerRolePageState extends State<SelectManagerRolePage> {
  late int employeeId;

  @override
  void initState() {
    super.initState();
    employeeId = Provider.of<EmployeeProvider>(context, listen: false)
        .employeeData!["id"];
  }

  Future<Map<String, bool>> getManagerRoles() async {
    final url = Uri.parse(
        "https://hr.qacc.ly/php/get_manager_roles.php?employee_id=$employeeId");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'is_direct_manager': data['is_direct_manager'] ?? false,
          'is_higher_manager': data['is_higher_manager'] ?? false,
        };
      } else {
        return {'is_direct_manager': false, 'is_higher_manager': false};
      }
    } catch (e) {
      print("Error fetching manager roles: $e");
      return {'is_direct_manager': false, 'is_higher_manager': false};
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
        child: FutureBuilder<Map<String, bool>>(
          future: getManagerRoles(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CustomLoadingIndicator());
            }

            final isDirect = snapshot.data!['is_direct_manager']!;
            final isHigher = snapshot.data!['is_higher_manager']!;

            return SingleChildScrollView(
              child: FadeInUp(
                duration: Duration(seconds: 1),
                child: Column(
                  children: [
                    Gap(20),
                    SectionHeader(title: 'اختر دورك في إدارة الطلبات'),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          if (isDirect)
                            Row(
                              children: [
                                Expanded(child: Container()),
                                Gap(15),
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () {
                                      context.router.push(
                                          RequestTypeSelectionWidget(
                                              onLeavesTap: () {
                                        context.router
                                            .push(DirectManagerLeavesApproval());
                                      }));
                                    },
                                    child: ImageTextCard(
                                      image: 'assets/images/Manager.png',
                                      mainText: 'مدير مباشر',
                                    ),
                                  ),
                                ),
                                Gap(15),
                                Expanded(child: Container()),
                              ],
                            ),
                          Gap(15),
                          if (isHigher)
                            Row(
                              children: [
                                Expanded(child: Container()),
                                const Gap(15),
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () {
                                      context.router.push(
                                          RequestTypeSelectionWidget(
                                              onLeavesTap: () {
                                        context.router
                                            .push(HigherManagerLeavesApproval());
                                      }));
                                    },
                                    child: ImageTextCard(
                                        image:
                                            'assets/images/Administrator_Male.png',
                                        mainText: 'مدير أعلى'),
                                  ),
                                ),
                                const Gap(15),
                                Expanded(child: Container()),
                              ],
                            ),
                          if (!isDirect && !isHigher)
                            const Text(
                                "ليس لديك صلاحية كمدير مباشر أو كمدير أعلى"),
                          Gap(20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
