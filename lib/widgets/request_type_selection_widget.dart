import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/router/app_router.gr.dart';
import 'package:qacc_application/widgets/image_text_card.dart';
import 'package:qacc_application/widgets/section_header.dart';

@RoutePage()
class RequestTypeSelectionWidget extends StatelessWidget {
  final VoidCallback? onLeavesTap;
  final VoidCallback? onItemsTap;
  final VoidCallback? onFormsTap;

  const RequestTypeSelectionWidget({
    super.key,
    this.onLeavesTap,
    this.onItemsTap,
    this.onFormsTap,
  });

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
                  SectionHeader(title: 'حدد نوع الطلب (اجازة - صنف - نموذج)'),
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
                                onTap: onLeavesTap,
                                child: ImageTextCard(
                                  image: 'assets/images/Google_Calendar.png',
                                  mainText: 'الإجازات',
                                ),
                              ),
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
                              child: InkWell(
                                onTap: onItemsTap,
                                child: ImageTextCard(
                                    image: 'assets/images/Create_Order.png',
                                    mainText: 'الأصناف'),
                              ),
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
                              child: InkWell(
                                onTap: onFormsTap,
                                child: ImageTextCard(
                                  image: 'assets/images/Signing_A_Document.png',
                                  mainText: 'النماذج',
                                ),
                              ),
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
          ),
        ));
  }
}
