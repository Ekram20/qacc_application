import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';

@RoutePage()
class LeaveInfoPage extends StatelessWidget {
  final String leaveName; // اسم الإجازة
  final String leaveDuration; // مدة الإجازة
  final String procedureStepsTitle; // عنوان خطوات الإجراء
  final String stepDescription; // وصف الخطوات
  final String stepOne; // الخطوة الأولى
  final String stepTwo; // الخطوة الثانية
  final String stepThree; // الخطوة الثانية
  final String stepFour; // الخطوة الثانية
  final String stepFive; // الخطوة الثانية

  const LeaveInfoPage({
    super.key,
    this.leaveName = '', // القيمة الافتراضية
    this.leaveDuration = '', // القيمة الافتراضية
    this.procedureStepsTitle = '', // القيمة الافتراضية
    this.stepDescription = '', // القيمة الافتراضية
    this.stepOne = '', // القيمة الافتراضية
    this.stepTwo = '', // القيمة الافتراضية
    this.stepThree = '', // القيمة الافتراضية
    this.stepFour = '', // القيمة الافتراضية
    this.stepFive = '', // القيمة الافتراضية
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الإجازة',
            style: Theme.of(context).textTheme.bodySmall),
        centerTitle: true,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leaveName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Gap(16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مدة الإجازة :',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Gap(10.0),
                      Expanded(
                        child: Text(
                          leaveDuration,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  const Gap(30.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(procedureStepsTitle,
                          style: Theme.of(context).textTheme.bodyLarge),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(stepDescription,
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            Gap(20.0),
                            Text(stepOne,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Gap(15.0),
                            Text(stepTwo,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Gap(15.0),
                            Text(stepThree,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Gap(15.0),
                            Text(stepFour,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Gap(15.0),
                            Text(stepFive,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
