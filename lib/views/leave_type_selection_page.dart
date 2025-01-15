import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/widgets/image_text_card.dart';
import 'package:qacc_application/widgets/section_header.dart';

@RoutePage()
class LeaveTypeSelectionPage extends StatelessWidget {
  const LeaveTypeSelectionPage({super.key});

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
                            child: ImageTextCard(
                                image: 'assets/images/Google_Calendar.png',
                                mainText: 'إجازة سنوية'),
                          ),
                          Gap(15),
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Medical_Bag.png',
                                mainText: 'إجازة مرضية'),
                          ),
                        ],
                      ),
                      Gap(15),
                      Row(
                        children: [
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Siren.png',
                                mainText: 'إجازة طارئة'),
                          ),
                          Gap(15),
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/UNICEF.png',
                                mainText: 'إجازة أمومة'),
                          ),
                        ],
                      ),
                      Gap(15),
                      Row(
                        children: [
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Diamond_Ring.png',
                                mainText: 'إجازة الزواج'),
                          ),
                          Gap(15),
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Paper.png',
                                mainText: 'إجازة الوفاة'),
                          ),
                        ],
                      ),
                      Gap(15),
                      Row(
                        children: [
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Kaaba.png',
                                mainText: 'إجازة الحج'),
                          ),
                          Gap(15),
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Grades.png',
                                mainText: 'إجازة الإمتحانات'),
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
        ));
  }
}
