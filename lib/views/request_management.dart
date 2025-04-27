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
import 'package:qacc_application/widgets/circularProgressIndicator.dart';
import 'package:qacc_application/widgets/image_text_card.dart';
import 'package:qacc_application/widgets/section_header.dart';

@RoutePage()
class RequestManagement extends StatefulWidget {
  const RequestManagement({super.key});

  @override
  State<RequestManagement> createState() => _RequestManagementState();
}

late int employeeId; 

class _RequestManagementState extends State<RequestManagement> {
  @override
  void initState() {
    super.initState();
    employeeId = Provider.of<EmployeeProvider>(context, listen: false)
        .employeeData!["id"];
  }

  Future<bool> isManager() async {
    final url = Uri.parse(
        "https://hr.qacc.ly/php/check_is_manager.php?employee_id=$employeeId");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['isManager'] == true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error checking manager status: $e");
      return false;
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
        child: FutureBuilder<bool>(
          future: isManager(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CustomLoadingIndicator());
            }

            final isUserManager = snapshot.data!;

            return 
            SingleChildScrollView(
              child: FadeInUp(
                duration: Duration(seconds: 1),
                child: Column(
                  children: [
                    Gap(20),
                    SectionHeader(title: 'حدد نوع الإجراء المطلوب'),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Container()),
                              Gap(15),
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    context.router
                                        .push(RequestTypeSelectionWidget(onLeavesTap: (){context.router.push(LeavesRequestsRoute());}));
                                  },
                                  child: ImageTextCard(
                                    image: 'assets/images/Map_Editing.png',
                                    mainText: 'مراجعة طلباتي',
                                  ),
                                ),
                              ),
                              Gap(15),
                              Expanded(child: Container()),
                            ],
                          ),
                          Gap(15),
                          if (isUserManager)
                            Row(
                              children: [
                                Expanded(child: Container()),
                                const Gap(15),
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () {
                                    context.router.push(SelectManagerRoleRoute());

                                    },
                                    child: ImageTextCard(
                                        image: 'assets/images/Services.png',
                                        mainText: 'إدارة الطلبات'),
                                  ),
                                ),
                                const Gap(15),
                                Expanded(child: Container()),
                              ],
                            ),

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
