import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';

class ImageTextCard extends StatelessWidget {
  const ImageTextCard({super.key, required this.image, required this.mainText});

  final String image;
  final String mainText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.secondaryColor.shade400, // لون الحدود
          width: 1.0, // سماكة الحدود
        ),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // توسيط المحتوى داخل الكرت
        mainAxisSize: MainAxisSize.min, // يجعل الارتفاع يعتمد على المحتوى
        children: [
          Image.asset(
            image, // مسار الصورة
            width: 50, // عرض الصورة (اختياري)
            height: 50, // ارتفاع الصورة (اختياري)
            fit: BoxFit.cover, // كيفية ملاءمة الصورة (اختياري)
          ),
          Gap(20),
          Text(
            mainText,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
