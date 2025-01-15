import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.image,
    this.onImageTap, // دالة اختيارية لاستجابة النقر على الصورة
  });

  final String title;
  final String? image;
  final VoidCallback? onImageTap; // دالة النقر على الصورة

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: AppColors.secondaryColor.shade100,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Spacer(),
              if (image != null)
              InkWell(
                onTap: onImageTap, // استدعاء الدالة عند النقر
                child: Image.asset(
                  image!,
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ));
  }
}
