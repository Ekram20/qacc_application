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
                  Text(
                    '''
1. المقدمة
تم تطوير هذا التطبيق كمنصة رقمية داخلية تهدف إلى تنظيم العمليات الإدارية والروتينية داخل مركز ضمان الجودة والمعايرة المهنية، وتقليل الاعتماد على الورق، بما يسهم في تحسين الكفاءة الإدارية وتحقيق التحول الرقمي.

2. نطاق الاستخدام
التطبيق مخصص لاستخدام موظفي مركز ضمان الجودة والمعايرة المهنية فقط.
يُستخدم لتقديم الطلبات الإدارية مثل:
• طلبات الإجازة بجميع أنواعها.
• طلب أصناف أو مستلزمات.
• عرض سجلات الحضور والانصراف.
• تقديم طلبات صيانة (خدمية أو إلكترونية).
• تلقي المراسلات الرسمية من المحفوظات أو من مدير عام المركز.
• طلب نماذج إدارية رقمية.
• مراجعة الطلبات من قبل المدراء (قبول/رفض).

3. السرية وحماية البيانات
جميع البيانات المدخلة عبر التطبيق (شخصية، وظيفية، إدارية) سرية ولا يمكن الاطلاع عليها من قبل مطوري النظام.
يتم تشفير البيانات أثناء نقلها وتخزينها باستخدام أحدث معايير الأمان.
يتم تطبيق ضوابط صارمة للتحقق من هوية المستخدمين وصلاحياتهم.
يُمنع مشاركة أو الاطلاع على البيانات من غير المخولين.
النظام يخضع لمراجعات دورية لضمان الأمان.

4. حساب المستخدم وتسجيل الدخول
يتم الدخول باستخدام البريد الإلكتروني (Gmail) المقدم مسبقًا.
لا حاجة لكلمة مرور، ويتم التحقق عبر Gmail.
يُعتبر البريد هوية المستخدم داخل التطبيق، ويتحمل المستخدم المسؤولية الكاملة.
عند تغيير البريد، يجب إخطار الإدارة المختصة.

5. استخدام التطبيق
يُستخدم التطبيق للأغراض الإدارية فقط.
يُمنع إدخال بيانات خاطئة أو إساءة استخدام الخدمات.
كل المعاملات تُعامل رسميًا وتُحفظ في السجلات.

6. صلاحيات المدراء
للمدراء صلاحية مراجعة واعتماد الطلبات وفق السياسات الداخلية.
يجب متابعة الإشعارات الصادرة من النظام باستمرار من جميع الأطراف.

7. الصيانة والدعم الفني
يُحدث التطبيق دوريًا لضمان الاستقرار.
في حال وجود أعطال، يتم التواصل مع الدعم الفني.
قد يتم توقيفه مؤقتًا للصيانة مع إخطار المستخدمين مسبقًا.

8. إخلاء المسؤولية
لا يتحمل المركز مسؤولية أي استخدام غير مصرح به أو بيانات خاطئة.

9. الملكية الفكرية
كل مكونات التطبيق ملك حصري للمركز.
يُمنع نسخ أو إعادة استخدام أي جزء دون إذن رسمي.

10. القانون المعمول به
تخضع هذه الشروط للوائح والسياسات الإدارية بالمركز.
يتم حل النزاعات وفق الإجراءات الداخلية.

11. التحديثات والتعديلات
يحق للمركز تعديل الشروط في أي وقت.
يتم إخطار المستخدمين بأي تغييرات جوهرية.

12. سياسة الاستخدام المقبول والحماية الإلكترونية
في حال إساءة الاستخدام، يحق للإدارة اتخاذ الإجراءات التأديبية المناسبة (تعطيل الحساب، إنذار إداري، تصعيد...).
              ''',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
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
