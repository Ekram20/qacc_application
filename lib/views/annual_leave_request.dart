import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/widgets/custom_text_field.dart';
import 'package:qacc_application/widgets/date_form_field.dart';
import 'package:qacc_application/widgets/large_button.dart';
import 'package:qacc_application/widgets/section_header.dart';
import 'package:auto_route/auto_route.dart';
import 'package:qacc_application/widgets/task_check_form.dart';

@RoutePage()
class AnnualLeaveRequest extends StatefulWidget {
  const AnnualLeaveRequest({super.key});

  @override
  State<AnnualLeaveRequest> createState() => _AnnualLeaveRequestState();
}

class _AnnualLeaveRequestState extends State<AnnualLeaveRequest> {
  final _formKey = GlobalKey<FormState>();
  bool isSubmitted = false; // لتتبع حالة الإرسال

  String? _selectedOption = "نعم"; // القيمة المختارة
  String? _selectedFile; // المتغير لتمثيل الملف الذي تم اختياره
  DateTime? _taskDate; // تاريخ التكليف
  DateTime? _requestDate; // تالريخ الطلب
  DateTime? _leaveStartDate;
  DateTime? _leaveEndDate;
  DateTime? _resumptionDate;
  // تعريف متغير للتحكم في تاريخ التكليف
  TextEditingController _taskDateController = TextEditingController();
  // تعريف متغير للتحكم في تاريخ الطلب
  TextEditingController _requestDateController = TextEditingController();
  // تعريف متغير للتحكم في عدد الأيام
  TextEditingController _daysController = TextEditingController();

  // التحكم في الحقول الإضافية
  TextEditingController _bookNumberController = TextEditingController();
  TextEditingController _taskController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _leaveStartController = TextEditingController();
  TextEditingController _leaveEndController = TextEditingController();
  TextEditingController _resumptionController = TextEditingController();

  // متغير لتخزين مسار الملف المختار
  File? _file;

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
                  title: 'نموذج طلب إجازة سنوية',
                  image: 'assets/images/Info.png',
                  onImageTap: () {},
                ),
                TaskCheckForm(
                  pdfTitle: 'ارفاق صورة من كتاب او قرار التكليف',
                  selectedOption: _selectedOption,
                  onOptionChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                  labelDateText: 'تاريخ التكليف',
                  taskDate: _taskDate,
                  controller: _taskDateController,
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
                      _taskDate = date;
                      _taskDateController.text =
                          "${_taskDate!.year}-${_taskDate!.month}-${_taskDate!.day}";
                    });
                  },
                  bookNumberController: _bookNumberController,
                  bookNumberValidator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال رقم الكتاب' : null,
                  taskController: _taskController,
                  taskValidator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال المهمة' : null,
                  departmentController: _departmentController,
                  departmentValidator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال اسم الإدارة' : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // حقل عدد الأيام
                          Expanded(
                            child: CustomTextField(
                              controller: _daysController,
                              keyboardType: TextInputType.number,
                              labelText: 'عدد الأيام',
                              icon: Icons.pin_outlined,
                              validator: (value) => value!.isEmpty
                                  ? 'يرجى إدخال عدد الأيام'
                                  : null,
                            ),
                          ),
                          Gap(10.0), // مسافة بين الحقول
                          // حقل عدد الأيام المسموح بها
                          Expanded(
                            child: CustomTextField(
                              controller: TextEditingController(text: "30"),
                              readOnly: true,
                              keyboardType: TextInputType.text,
                              labelText: 'عدد الأيام المسموح بها',
                              icon: Icons.description_outlined,
                            ),
                          ),
                        ],
                      ),

                      Gap(10.0), // مسافة بين الحقول

                      DateFormField(
                        labelText: 'تاريخ الطلب',
                        controller: _requestDateController,
                        onDateSelected: (date) {
                          setState(() {
                            _requestDate = date;
                            _requestDateController.text =
                                "${_requestDate!.year}-${_requestDate!.month}-${_requestDate!.day}";
                          });
                        },
                        validator: (value) =>
                            value!.isEmpty ? 'يرجى إدخال تاريخ الطلب' : null,
                      ),
                      Gap(10.0),
                      Row(
                        children: [
                          // حقل عدد الأيام
                          Expanded(
                            child: DateFormField(
                              labelText: 'تاريخ بداية الإجازة',
                              controller: _leaveStartController,
                              onDateSelected: (date) {
                                setState(() {
                                  _leaveStartDate = date;
                                  _leaveStartController.text =
                                      "${_leaveStartDate!.year}-${_leaveStartDate!.month}-${_leaveStartDate!.day}";
                                });
                              },
                              validator: (value) => value!.isEmpty
                                  ? 'يرجى إدخال تاريخ بداية الإجازة'
                                  : null,
                            ),
                          ),
                          Gap(10.0), // مسافة بين الحقول
                          // حقل عدد الأيام المسموح بها
                          Expanded(
                            child: DateFormField(
                              labelText: 'تاريخ نهاية الإجازة',
                              readOnly: true,
                              controller: _leaveEndController,
                              onDateSelected: (date) {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Gap(10.0),
                      DateFormField(
                        labelText: 'تاريخ المباشرة',
                        controller: _resumptionController,
                        onDateSelected: (date) {
                          setState(() {});
                        },
                      ),
                      Gap(20.0),
                      LargeButton(buttonText: 'إرسال الطلب',
                      onPressed: _submitForm,),
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
    if (_selectedOption == "نعم") {
      // إذا تم اختيار "نعم" فقط يتم التحقق من الحقول
      if (_formKey.currentState!.validate()) {
        // تحقق إضافي لضمان أن الملف موجود عند اختيار "نعم"
        if (_selectedOption == "نعم" && _file == null) {
          return; // إيقاف الإرسال إذا لم يتم اختيار ملف
        }
        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          '_selectedOption': _selectedOption,
          '_taskDate': _taskDateController.text,
          '_file': _file,
          '_bookNumberController': _bookNumberController.text,
          '_taskController': _taskController.text,
          '_departmentController': _departmentController.text,
        };

        // عرض رسالة نجاح بعد إرسال البيانات
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('البيانات: $requestData'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else if (_selectedOption == "لا") {
      // إذا تم اختيار "لا"، يتم تجاهل النموذج بالكامل وعدم التحقق
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تحديد لا بدون التحقق من الحقول'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
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
