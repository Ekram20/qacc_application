import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/widgets/custom_text_field.dart';
import 'package:qacc_application/widgets/date_form_field_widget.dart';
import 'package:qacc_application/widgets/large_button.dart';
import 'package:qacc_application/widgets/leave_reason_field.dart';
import 'package:qacc_application/widgets/pdf_widget.dart';
import 'package:qacc_application/widgets/section_header.dart';

@RoutePage()
class EmergencyLeaveRequest extends StatefulWidget {
  const EmergencyLeaveRequest({super.key});

  @override
  State<EmergencyLeaveRequest> createState() => _EmergencyLeaveRequestState();
}

class _EmergencyLeaveRequestState extends State<EmergencyLeaveRequest> {
  final _formKey = GlobalKey<FormState>();

  File? _file;
  String? _selectedFile; // المتغير لتمثيل الملف الذي تم اختياره
  bool isSubmitted = false; // لتتبع حالة الإرسال

  // تعريف متغير للتحكم في عدد الأيام
  TextEditingController daysController = TextEditingController();
  // تعريف متغير للتحكم في تاريخ الطلب
  TextEditingController requestDateController = TextEditingController();
  // تعريف متغير للتحكم في تاريخ البداية
  TextEditingController leaveStartController = TextEditingController();
  // تعريف متغير للتحكم في تاريخ نهاية
  TextEditingController leaveEndController = TextEditingController();
  // تعريف متغير للتحكم في تاريخ المباشرة
  TextEditingController resumptionController = TextEditingController();
  // تعريف متغير للتحكم في سبب الإجازة
  TextEditingController leaveReasonController = TextEditingController();

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gap(20),
                SectionHeader(
                  title: 'نموذج طلب إجازة طارئة',
                  image: 'assets/images/Info.png',
                  onImageTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Gap(16.0),
                      CustomTextField(
                        controller: daysController,
                        keyboardType: TextInputType.number,
                        labelText: 'أدخل عدد الأيام',
                        icon: Icons.onetwothree_outlined,
                        validator: (value) =>
                            value!.isEmpty ? 'يرجى إدخال عدد الأيام' : null,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      Gap(16.0), // مسافة بين الحقول
                      // حقل عدد الأيام المسموح بها
                      CustomTextField(
                        controller: TextEditingController(text: "30"),
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        labelText: 'عدد الأيام المسموح بها',
                        icon: Icons.pin_rounded,
                      ),
                      Gap(16.0),
                      LeaveReasonField(
                        onChanged: (value) {
                          leaveReasonController.text = value; // حفظ النص
                        },
                      ),
                      Gap(16.0),
                      DateFormFieldWidget(
                        days: int.tryParse(daysController.text) ??
                            0, // تمرير حقل عدد الأيام
                        requestDateController: requestDateController,
                        startDateController: leaveStartController,
                        endDateController: leaveEndController,
                        resumeDateController: resumptionController,
                      ),
                      Gap(16.0),
                      PdfWidget(
                        title: 'إرفاق ملف',
                        file: _file,
                        openFilePicker: _openFilePicker,
                        onFilePicked: (file) {
                          setState(() {
                            _file = file;
                          });
                        },
                        validator: (value) => _file == null && isSubmitted
                            ? 'يرجى إرفاق ملف'
                            : null,
                      ),

                      Gap(10.0),
                      LargeButton(
                        buttonText: 'إرسال الطلب',
                        color: AppColors.primaryColor,
                        onPressed: _submitForm,
                      ),
                      Gap(20.0),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    setState(() {
      isSubmitted = true; // تعيين حالة الإرسال إلى true
    });

    // إذا تم اختيار "نعم" فقط يتم التحقق من الحقول
    if (_formKey.currentState!.validate()) {
      // تحقق إضافي لضمان أن الملف موجود عند اختيار "نعم"
      if (_file == null) {
        return; // إيقاف الإرسال إذا لم يتم اختيار ملف
      }
      // إضافة البيانات إلى الكائن requestData
      Map<String, dynamic> requestData = {
        'daysController': daysController.text,
        'leaveReasonController':
            leaveReasonController.text, // إضافة سبب الإجازة
        'requestDateController': requestDateController.text,
        'leaveStartController': leaveStartController.text,
        'leaveEndController': leaveEndController.text,
        'resumptionController': resumptionController.text,
        'file': _file,
      };

      // عرض رسالة نجاح بعد إرسال البيانات
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('البيانات: $requestData'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      // إعادة تعيين الحقول بعد الإرسال
      setState(() {
        daysController.clear();
        leaveReasonController.clear();
        leaveStartController.clear();
        leaveEndController.clear();
        resumptionController.clear();
        _file = null; // إعادة تعيين الملف
        isSubmitted = false;
      });
    }
  }

  // فتح نافذة لاختيار الملف
  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.single.name;
        _file = File(result.files.single.path!); // حفظ المسار للملف المختار
      });
    }
  }
}
