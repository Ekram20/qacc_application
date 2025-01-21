import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/widgets/date_form_field_widget.dart';
import 'package:qacc_application/widgets/large_button.dart';
import 'package:qacc_application/widgets/pdf_widget.dart';
import 'package:qacc_application/widgets/section_header.dart';
import 'package:qacc_application/widgets/task_check_form.dart';

@RoutePage()
class MaternityLeaveRequest extends StatefulWidget {
  const MaternityLeaveRequest({super.key});

  @override
  State<MaternityLeaveRequest> createState() => _MaternityLeaveRequestState();
}

class _MaternityLeaveRequestState extends State<MaternityLeaveRequest> {
  final _formKey = GlobalKey<FormState>();

  // متغير لتخزين مسار الملف المختار
  File? _file;
  String? _selectedFile; // المتغير لتمثيل الملف الذي تم اختياره

  File? attachedMedicalFile;
  String? attachedMedicalFileName;

  bool isSubmitted = false; // لتتبع حالة الإرسال
  bool isSubmittedStateNo = false;

  String? _selectedOption = "نعم"; // القيمة المختارة
  String? _selectedDays = "14 أسبوعًا (طفل واحد)"; // القيمة المختارة

  // تعريف متغير للتحكم في تاريخ التكليف
  TextEditingController taskDateController = TextEditingController();
  // التحكم في حقل رقم الكتاب
  TextEditingController bookNumberController = TextEditingController();
  // التحكم في حقل المهمة
  TextEditingController taskController = TextEditingController();
  // التحكم في حقل الإدارة
  TextEditingController departmentController = TextEditingController();

  // تعريف متغير للتحكم في عدد الأيام
  TextEditingController daysController =
      TextEditingController(text: (14 * 7).toString()); // 14 أسبوعًا = 98 يومًا
  // تعريف متغير للتحكم في تاريخ الطلب
  TextEditingController requestDateController = TextEditingController();
  // تعريف متغير للتحكم في تاريخ البداية
  TextEditingController leaveStartController = TextEditingController();
  // تعريف متغير للتحكم في تاريخ نهاية
  TextEditingController leaveEndController = TextEditingController();
  // تعريف متغير للتحكم في تاريخ المباشرة
  TextEditingController resumptionController = TextEditingController();

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
                  title: 'نموذج طلب إجازة أمومة',
                  image: 'assets/images/Info.png',
                  onImageTap: () {},
                ),
                TaskCheckForm(
                  pdfTitle: 'ارفاق صورة من كتاب او قرار التكليف',
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
                  dateValidator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال تاريخ التكليف' : null,
                  pdfValidator: (value) => _file == null && isSubmitted
                      ? 'يرجى إرفاق ملف PDF'
                      : null, // تحقق من الملف فقط عند الإرسال
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
                ),
                             Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'حدد مدة الإجازة',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: "14 أسبوعًا (طفل واحد)",
                            groupValue: _selectedDays,
                            onChanged: (value) {
                              setState(() {
                                _selectedDays = value!;
                                daysController.text = (14 * 7).toString(); // 14 أسبوعًا = 98 يومًا
                              });
                            },
                          ),
                          Text("14 أسبوعًا (طفل واحد)"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: "16 أسبوعًا (أكثر من طفل)",
                            groupValue: _selectedDays,
                            onChanged: (value) {
                              setState(() {
                                _selectedDays = value!;
                                daysController.text = (16 * 7).toString(); // 16 أسبوعًا = 112 يومًا
                              });
                            },
                          ),
                          Text("16 أسبوعًا (أكثر من طفل)"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [

                      Gap(25.0), // مسافة بين الحقول
                      DateFormFieldWidget(
                        days: int.tryParse(daysController.text) ?? 0, // تمرير حقل عدد الأيام
                        requestDateController: requestDateController,
                        startDateController: leaveStartController,
                        endDateController: leaveEndController,
                        resumeDateController: resumptionController,
                      ),
                      Gap(16.0),
                      PdfWidget(
                        title: 'إرفاق الشهادة الطبية',
                        file: attachedMedicalFile,
                        openFilePicker: _openMedicalFilePicker,
                        onFilePicked: (file) {
                          setState(() {
                            attachedMedicalFile = file;
                          });
                        },
                        validator: (value) =>
                            attachedMedicalFile == null && isSubmittedStateNo
                                ? 'يرجى إرفاق الشهادة الطبية'
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
      isSubmittedStateNo = true; // تعيين حالة الإرسال إلى true
    });

    if (_selectedOption == "نعم") {
      setState(() {
        isSubmitted = true; // تعيين حالة الإرسال إلى true
      });
      // إذا تم اختيار "نعم" فقط يتم التحقق من الحقول
      if (_formKey.currentState!.validate()) {
        // تحقق إضافي لضمان أن الملف موجود عند اختيار "نعم"
        if (_selectedOption == "نعم" && _file == null) {
          return; // إيقاف الإرسال إذا لم يتم اختيار ملف
        }
        if (attachedMedicalFile == null) {
          return; // إيقاف الإرسال إذا كان الملف الطبي فارغًا
        }
        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          '_selectedDays': _selectedDays,
          'taskDateController': taskDateController.text,
          '_file': _file,
          'bookNumberController': bookNumberController.text,
          'taskController': taskController.text,
          'departmentController': departmentController.text,
          'daysController': daysController.text,
          'requestDateController': requestDateController.text,
          'leaveStartController': leaveStartController.text,
          'leaveEndController': leaveEndController.text,
          'resumptionController': resumptionController.text,
          'attachedMedicalFile': attachedMedicalFile,
        };

        // عرض رسالة نجاح بعد إرسال البيانات
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('البيانات: $requestData'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        _resetFields();
      }
    } else if (_selectedOption == "لا") {
      // إذا تم اختيار "نعم" فقط يتم التحقق من الحقول
      if (_formKey.currentState!.validate()) {
        if (attachedMedicalFile == null) {
          return; // إيقاف الإرسال إذا كان الملف الطبي فارغًا
        }
        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          '_selectedDays': _selectedDays,
          'daysController': daysController.text,
          'requestDateController': requestDateController.text,
          'leaveStartController': leaveStartController.text,
          'leaveEndController': leaveEndController.text,
          'resumptionController': resumptionController.text,
          'attachedMedicalFile': attachedMedicalFile,
        };

        // عرض رسالة نجاح بعد إرسال البيانات
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('البيانات: $requestData'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        _resetFields();
      }
    }
  }

// دالة لإعادة تعيين الحقول
  void _resetFields() {
    setState(() {
      // إعادة تعيين قيم الحقول
      taskDateController.clear();
      bookNumberController.clear();
      taskController.clear();
      departmentController.clear();
      daysController.clear();
      leaveStartController.clear();
      leaveEndController.clear();
      resumptionController.clear();

      // إعادة تعيين الملفات والمتغيرات الأخرى
      _file = null;
      attachedMedicalFile = null;
      isSubmitted = false;
      isSubmittedStateNo = false;
    });
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

  // فتح نافذة لاختيار الملف الطبي
  void _openMedicalFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        attachedMedicalFileName = result.files.single.name;
        attachedMedicalFile =
            File(result.files.single.path!); // حفظ المسار للملف الطبي
      });
    }
  }
}
