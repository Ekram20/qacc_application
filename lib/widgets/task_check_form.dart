import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/widgets/custom_text_field.dart';
import 'package:qacc_application/widgets/date_form_field.dart';
import 'package:qacc_application/widgets/pdf_widget.dart';

class TaskCheckForm extends StatelessWidget {
  const TaskCheckForm({
    super.key,
    required this.pdfTitle,
    required this.selectedOption,
    required this.onOptionChanged,
    required this.taskDate,
    required this.controller,
    required this.file,
    required this.openFilePicker,
    required this.onFilePicked,
    required this.onDateSelected,
    required this.bookNumberController,
    required this.taskController,
    required this.departmentController,
    required this.bookNumberValidator, // إضافة parameter للتحقق من رقم الكتاب
    required this.taskValidator, // إضافة parameter للتحقق من المهمة
    required this.departmentValidator, // إضافة parameter للتحقق من اسم الإدارة
    required this.pdfValidator, // إضافة parameter للتحقق من الملف PDF
    required this.dateValidator,
  });

  final String pdfTitle;
  final String? selectedOption;
  final ValueChanged<String?> onOptionChanged;
  final DateTime? taskDate;
  final TextEditingController controller;
  final File? file;
  final Function openFilePicker;
  final Function(File) onFilePicked;
  final Function(DateTime) onDateSelected;
  final TextEditingController bookNumberController;
  final TextEditingController taskController;
  final TextEditingController departmentController;
  // التحقق من الحقول
  final String? Function(String?)? bookNumberValidator;
  final String? Function(String?)? taskValidator;
  final String? Function(String?)? departmentValidator;
  final String? Function(String?)? pdfValidator;
  final String? Function(String?)? dateValidator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text('هل تم تكليفك بواجب أو مهمة معينة للقيام بها',
                style: Theme.of(context).textTheme.bodyMedium),
            Row(
              children: [
                Radio<String>(
                  value: "نعم",
                  groupValue: selectedOption,
                  onChanged: onOptionChanged,
                ),
                Text("نعم"),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: "لا",
                  groupValue: selectedOption,
                  onChanged: onOptionChanged,
                ),
                Text("لا"),
              ],
            ),
            SizedBox(height: 20),
            // عرض سطر إرفاق ملف PDF فقط عند اختيار "نعم"
            if (selectedOption == "نعم")
              Column(
                children: [
                  CustomTextField(
                      controller: bookNumberController,
                      labelText: 'رقم الكتاب',
                      icon: Icons.numbers,
                      validator: bookNumberValidator),
                  Gap(15.0),
                  DateFormField(
                    controller: controller,
                    validator: dateValidator,
                    onDateSelected: (date) {
                      // أي تغييرات تتعلق بالتاريخ
                      onDateSelected(
                          date!); // تأكد من تحديث التاريخ في الـ State
                    },
                  ),
                  Gap(15.0),
                  CustomTextField(
                      controller: taskController,
                      labelText: 'المهمة',
                      icon: Icons.task_alt,
                      validator: taskValidator),
                  Gap(15.0),
                  CustomTextField(
                      controller: departmentController,
                      labelText: 'اسم الادارة الصادر منها التكليف',
                      icon: Icons.apartment,
                      validator: departmentValidator),
                  Gap(25.0),
                  PdfWidget(
                      title: pdfTitle,
                      file: file,
                      openFilePicker: openFilePicker,
                      onFilePicked: onFilePicked,
                      validator: pdfValidator),
                  Gap(15.0),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
