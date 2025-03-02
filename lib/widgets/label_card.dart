import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';

class LabelCard extends StatelessWidget {
  const LabelCard({super.key,required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: AppColors.secondaryColor.shade400, // لون الحدود
        //   width: 1.0, // سماكة الحدود
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // لون الظل مع شفافية
            spreadRadius: 2, // انتشار الظل
            blurRadius: 8, // درجة تمويه الظل
            offset: Offset(4, 4), // إزاحة الظل (أفقيًا وعموديًا)
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1), // لون ظل معاكس لعمق أكبر
            spreadRadius: -2, // انتشار عكسي
            blurRadius: 8,
            offset: Offset(-4, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // توسيط المحتوى داخل الكرت
          mainAxisSize: MainAxisSize.min, // يجعل الارتفاع يعتمد على المحتوى
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    AppColors.secondaryColor.shade600,
                    AppColors.primaryColor.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: Icon(
              Icons.arrow_circle_left_rounded,
              color: AppColors.secondaryColor.shade600,
              size: 45.0,
            ),
            ),

          ],
        ),
      ),
    );
  }
}
