import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/widgets/animated_text.dart';
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
            child: FadeInUp(
              duration: Duration(seconds: 1),
              child: Column(
                children: [
                  Gap(20),
                  SectionHeader(title: 'الملف المعني للموظف'),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Gap(10.0),
                        Row(
                          children: [
                            Expanded(
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  ImageTextCard(
                                      image: 'assets/images/Audit.png',
                                      mainText: 'التكليفات'),
                                  Positioned(
                                      top: -15,
                                      child: AnimatedText(
                                        texts: ['قريباً', 'ترقبوا'],
                                        startIndex: 0,
                                      )),
                                ],
                              ),
                            ),
                            Gap(15),
                            Expanded(
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  ImageTextCard(
                                      image: 'assets/images/Business_Group.png',
                                      mainText: 'الزيارات'),
                                  Positioned(
                                      top: -15,
                                      child: AnimatedText(
                                        texts: ['قريباً', 'ترقبوا'],
                                        startIndex: 0,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(25),
                        Row(
                          children: [
                            Expanded(
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  ImageTextCard(
                                      image:
                                          'assets/images/People_Skin_Type.png',
                                      mainText: 'تشكيل لجان'),
                                  Positioned(
                                      top: -15,
                                      child: AnimatedText(
                                        texts: ['قريباً', 'ترقبوا'],
                                        startIndex: 0,
                                      )),
                                ],
                              ),
                            ),
                            Gap(15),
                            Expanded(
                              child: Opacity(
                                opacity: 0.5,
                                child: ImageTextCard(
                                    image: 'assets/images/Ratings.png',
                                    mainText: 'تقرير الكفاءة \n السنوية'),
                              ),
                            ),
                          ],
                        ),
                        Gap(25),
                        Row(
                          children: [
                            Expanded(
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  ImageTextCard(
                                    image: 'assets/images/Present_to_All.png',
                                    mainText: 'قرارات ترقيات',
                                  ),
                                  Positioned(
                                      top: -15,
                                      child: AnimatedText(
                                        texts: ['قريباً', 'ترقبوا'],
                                        startIndex: 0,
                                      )),
                                ],
                              ),
                            ),
                            Gap(25),
                            Expanded(
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  ImageTextCard(
                                      image:
                                          'assets/images/Google_Calendar.png',
                                      mainText: 'الإجازات'),
                                  Positioned(
                                      top: -15,
                                      child: AnimatedText(
                                        texts: ['قريباً', 'ترقبوا'],
                                        startIndex: 0,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(25),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topCenter,
                          children: [
                            LabelCard(label: 'أخرى'),
                            Positioned(
                                top: -15,
                                child: AnimatedText(
                                  texts: ['قريباً', 'ترقبوا'],
                                  startIndex: 0,
                                )),
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
