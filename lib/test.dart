import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/widgets/image_text_card.dart';
import 'package:qacc_application/widgets/section_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Gap(20),
                SectionHeader(title: 'حدد نوع الإجازة'),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Google_Calendar.png',
                                mainText: 'إجازة سنوية'),
                          ),
                          Gap(20),
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/medical_bag.png',
                                mainText: 'إجازة مرضية'),
                          ),
                        ],
                      ),
                      Gap(20),
                      Row(
                        children: [
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Siren.png',
                                mainText: 'إجازة طارئة'),
                          ),
                          Gap(20),
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/UNICEF.png',
                                mainText: 'إجازة أمومة'),
                          ),
                        ],
                      ),
                      Gap(20),
                      Row(
                        children: [
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Diamond_Ring.png',
                                mainText: 'إجازة الزواج'),
                          ),
                          Gap(20),
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Paper.png',
                                mainText: 'إجازة الوفاة'),
                          ),
                        ],
                      ),
                      Gap(20),
                                            Row(
                        children: [
                          Expanded(
                            child: ImageTextCard(
                                image: 'assets/images/Kaaba.png',
                                mainText: 'إجازة الحج'),
                          ),
                          Gap(20),
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
          )),
    );
  }
}
