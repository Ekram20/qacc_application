import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';

class NoteBox extends StatelessWidget {
  const NoteBox({
    super.key,
    required this.firstNote,
    required this.secondNotes,
  });
  final String firstNote; // الملاحظة الأولى
  final String secondNotes; // الملاحظة الثانية
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ملاحظة', style: Theme.of(context).textTheme.bodyMedium),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(firstNote,
                      style: Theme.of(context).textTheme.bodyMedium),
                  Gap(15.0),
                  Text(secondNotes,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
