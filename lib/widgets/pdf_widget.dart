import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/router/app_router.gr.dart';
import 'package:file_picker/file_picker.dart';
import 'package:auto_route/auto_route.dart';

class PdfWidget extends StatelessWidget {
  final String title;
  final File? file;
  final Function openFilePicker;
  final Function(File) onFilePicked;
  final String? Function(String?)? validator; // تم إضافة هذه السطر

  PdfWidget({
    required this.title,
    required this.file,
    required this.openFilePicker,
    required this.onFilePicked,
    required this.validator, // أخذ الـ validator كـ parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(title),
            ),
            SizedBox(width: 15),
            // زر اختيار PDF فقط إذا لم يتم اختيار ملف
            if (file == null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor.shade500,
                ),
                child: MaterialButton(
                  onPressed: () {
                    openFilePicker();
                  },
                  child:
                      Text('PDF', style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
            SizedBox(height: 20),
            // إذا تم اختيار الملف، عرض الزر "فتح PDF"
            if (file != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor.shade500,
                ),
                child: MaterialButton(
                  onPressed: () {
                    context.router.push(
                      PDFViewerRoute(pdfPath: file!.path),
                    );
                  },
                  child: Text('فتح PDF',
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
          ],
        ),
        // تحقق من وجود الملف عند إرسال النموذج
        if (validator != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              validator!(null) ?? "", // سيعرض رسالة خطأ إذا لم يتم اختيار الملف
              style: TextStyle(color: Color(0xFFBB362F)),
            ),
          ),
      ],
    );
  }
}
