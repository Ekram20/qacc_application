import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:auto_route/auto_route.dart';

import '../models/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/date_form_field_widget.dart';
import '../widgets/large_button.dart';
import '../widgets/pdf_widget.dart';
import '../widgets/section_header.dart';
import '../widgets/task_check_form.dart';

@RoutePage()
class ExamsLeave extends StatefulWidget {
  const ExamsLeave({super.key});

  @override
  State<ExamsLeave> createState() => _ExamsLeaveState();
}

class _ExamsLeaveState extends State<ExamsLeave> {
  final TextEditingController requestDateController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController resumeDateController = TextEditingController();
  final TextEditingController taskDateController = TextEditingController();
  final TextEditingController bookNumberController = TextEditingController();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  // تعريف متغير للتحكم في عدد الأيام
  TextEditingController daysController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _selectedOption = "نعم";
  bool isSubmitted = false;
  File? _file;

  File? attachedMarriageFile;
  String? _attachedMarriageFileName;
  bool isSubmittedStateNo = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(
            Icons.arrow_circle_left_rounded,
            color: Colors.white,
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
                const Gap(20),
                SectionHeader(
                  title: 'طلب إجازة امتحانات',
                  image: 'assets/images/Info.png',
                  onImageTap: () {},
                ),
                TaskCheckForm(
                  pdfTitle: 'إرفاق صورة من كتاب أو قرار التكليف',
                  selectedOption: _selectedOption,
                  onOptionChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                      isSubmitted = false;
                      _file = null;
                    });
                  },
                  labelDateText: 'تاريخ التكليف',
                  controller: taskDateController,
                  file: _file,
                  openFilePicker: _openFilePicker,
                  onFilePicked: (file) {
                    setState(() {
                      _file = file;
                    });
                  },
                  onDateSelected: (date) {
                    setState(() {
                      taskDateController.text =
                      "${date.year}-${date.month}-${date.day}";
                    });
                  },
                  bookNumberController: bookNumberController,
                  bookNumberValidator: (value) =>
                  value!.isEmpty ? 'يرجى إدخال رقم الكتاب' : null,
                  taskController: taskController,
                  taskValidator: (value) =>
                  value!.isEmpty ? 'يرجى إدخال المهمة' : null,
                  departmentController: departmentController,
                  departmentValidator: (value) =>
                  value!.isEmpty ? 'يرجى إدخال اسم الإدارة' : null,
                  pdfValidator: (value) =>
                  _file == null && isSubmitted
                      ? 'يرجى إرفاق ملف PDF'
                      : null,
                  dateValidator: (value) =>
                  value!.isEmpty ? 'يرجى إدخال تاريخ التكليف' : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextField(
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
                ),

                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      DateFormFieldWidget(
                         days: int.tryParse(daysController.text) ??
                          0,
                        requestDateController: requestDateController,
                        startDateController: startDateController,
                        endDateController: endDateController,
                        resumeDateController: resumeDateController,
                      ),
                      Gap(15),
                      PdfWidget(
                        title: 'إرفاق صورة من نتيجة الامتحانات',
                        file: attachedMarriageFile,
                        openFilePicker: _openMarriageFilePicker,
                        onFilePicked: (file) {
                          setState(() {
                            attachedMarriageFile = file;
                          });
                        },
                        validator: (value) =>
                        attachedMarriageFile == null && isSubmittedStateNo
                            ? 'يرجى إرفاق صورة من نتيجة الامتحانات '
                            : null,
                      ),
                      const Gap(20),
                      LargeButton(
                        buttonText: 'إرسال الطلب',
                        color: AppColors.primaryColor,
                        onPressed: _submitForm,
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  /// دالة فتح منتقي الملفات
  Future<void> _openFilePicker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  void _submitForm() {
    setState(() {
      isSubmittedStateNo = true; // تعيين حالة الإرسال إلى true
    });

    if (_selectedOption == "نعم") {
      setState(() {
        isSubmitted = true; // تعيين حالة الإرسال إلى true
      });

      // التحقق من الحقول عند اختيار "نعم"
      if (_formKey.currentState!.validate()) {
        // التحقق من وجود الملف إذا تم اختيار "نعم"
        if (_file == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("يرجى إرفاق الملف عند اختيار 'نعم'."),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          '_selectedOption': _selectedOption,
          'taskDate': taskDateController.text,
          '_file': _file,
          'bookNumber': bookNumberController.text,
          'task': taskController.text,
          'department': departmentController.text,
          'requestDate': requestDateController.text,
          'startDate': startDateController.text,
          'endDate': endDateController.text,
          'resumeDate': resumeDateController.text,
        };

        // عرض رسالة نجاح
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم إرسال البيانات بنجاح: $requestData'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        _resetFields(); // إعادة تعيين الحقول
      }
    } else if (_selectedOption == "لا") {
      // التحقق من الحقول عند اختيار "لا"
      if (_formKey.currentState!.validate()) {
        // التحقق من وجود الملف الطبي
        if (attachedMarriageFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("يرجى إرفاق الملف الطبي."),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          'requestDate': requestDateController.text,
          'startDate': startDateController.text,
          'endDate': endDateController.text,
          'resumeDate': resumeDateController.text,
          'taskDate': taskDateController.text,
          'bookNumber': bookNumberController.text,
          'task': taskController.text,
          'department': departmentController.text,
          'fileAttached': _file != null,
        };

        // عرض رسالة نجاح
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم إرسال البيانات بنجاح: $requestData'),
            backgroundColor: Colors.green,
          ),
        );
        _resetFields(); // إعادة تعيين الحقول
      }
    } else {
      // عرض رسالة خطأ عند وجود مشكلة في التحقق
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى التأكد من تعبئة جميع الحقول المطلوبة."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

// دالة لإعادة تعيين الحقول
  void _resetFields() {
    setState(() {
      startDateController.clear();
      endDateController.clear();
      resumeDateController.clear();
      taskDateController.clear();
      bookNumberController.clear();
      taskController.clear();
      departmentController.clear();
      daysController.clear();
      _file = null;
      _selectedOption = "نعم";
      isSubmitted = false;
      isSubmittedStateNo = false;
      attachedMarriageFile = null;
    });
  }

  // فتح نافذة لاختيار الملف وثيقة نتيجة الامتحان
  void _openMarriageFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _attachedMarriageFileName = result.files.single.name;
        attachedMarriageFile =
            File(result.files.single.path!); // حفظ المسار للملف الطبي
      });
    }
  }

}
