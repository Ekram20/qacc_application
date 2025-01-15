import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/widgets/image_text_card.dart';
import 'package:qacc_application/widgets/label_card.dart';
import 'package:qacc_application/widgets/section_header.dart';

class EmployeeFiles extends StatelessWidget {
  const EmployeeFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(20),
                SectionHeader(title: 'الملف المعني للموظف'),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Audit.png',
                                mainText: 'التكليفات'),
                          ),
                          Gap(15),
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Business_Group.png',
                                mainText: 'الزيارات'),
                          ),
                        ],
                      ),
                      Gap(15),
                      Row(
                        children: [
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/People_Skin_Type.png',
                                mainText: 'تشكيل لجان'),
                          ),
                          Gap(15),
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Ratings.png',
                                mainText: 'تقرير الكفاءة \n السنوية'),
                          ),
                        ],
                      ),
                      Gap(15),
                      Row(
                        children: [
                          Expanded(
                            child: ImageTextCard(
                              image: 'assets/images/Present_to_All.png',
                              mainText: 'قرارات ترقيات',
                            ),
                          ),
                          Gap(15),
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Google_Calendar.png',
                                mainText: 'الإجازات'),
                          ),
                        ],
                      ),
                      Gap(15),
                      LabelCard(label: 'أخرى'),
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
