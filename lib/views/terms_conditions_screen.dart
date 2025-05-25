import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';

@RoutePage()
class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor.shade50,
      appBar: AppBar(
        title: Text('الشروط والأحكام والقوانين',
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
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحبًا بك في تطبيق المركز!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Gap(12),
                  Text(
                    '''
يسعدنا انضمامك لنا في رحلة التحول الرقمي، حيث يهدف هذا التطبيق إلى تسهيل إجراءاتك اليومية داخل المركز، مثل تقديم طلبات الإجازة، الوصول إلى النماذج والأصناف، تلقي الإعلانات والرسائل، وغير ذلك من المهام الإدارية التي كانت تستغرق وقتاً وجهداً.

نرجو قراءة الشروط التالية بعناية، حيث يعتبر استخدامك للتطبيق موافقة ضمنية على جميع ما يلي:
                    ''',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                  const Gap(20),
                  Text('''

1. البند الأول.

2. البند الثاني.

3. البند الثالث.

4. البند الرابع.

شكراً لتفهمك.
              ''', style: Theme.of(context).textTheme.headlineSmall),
                  Gap(20.0),
                  const Gap(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
