import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import '../widgets/date_form_field_widget.dart';
import '../widgets/section_header.dart';
import '../widgets/date_form_field_widget_fs.dart';

@RoutePage()
class MarriageLeavePage extends StatelessWidget {
  MarriageLeavePage({Key? key}) : super(key: key);

  // تعريف الـ controllers هنا
  final TextEditingController requestDateController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController resumeDateController = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              const SectionHeader(title: 'إجازة زواج'),
              const Gap(16),
              // تمرير الـ controllers إلى الويدجت
              DateFormFieldWidget(
                days: 14, // تغيير قيمة الأيام حسب الحاجة
                requestDateController: requestDateController,
                startDateController: startDateController,
                endDateController: endDateController,
                resumeDateController: resumeDateController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
