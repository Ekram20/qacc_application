import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/widgets/image_text_card.dart';
import 'package:qacc_application/widgets/section_header.dart';

@RoutePage()
class MaintenanceRequestType extends StatelessWidget {
  const MaintenanceRequestType({super.key});

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
                SectionHeader(title: 'حدد نوع الصيانة المطلوب'),
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
                            child: ImageTextCard(
                                image: 'assets/images/Computer_Support.png',
                                mainText: 'طلب الكتروني'),
                          ),
                          Gap(15),
                          Expanded(child: Container()),
                        ],
                      ),
                      Gap(15),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Gap(15),
                          Expanded(
                            flex: 2,
                            child: ImageTextCard(
                                image: 'assets/images/Engineer.png',
                                mainText: 'طلب خدمي'),
                          ),
                          Gap(15),
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
        ));
  }
}
