import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/widgets/custom_text_field.dart';
import 'package:qacc_application/widgets/date_form_field_widget.dart';
import 'package:qacc_application/widgets/large_button.dart';
import 'package:qacc_application/widgets/pdf_widget.dart';
import 'package:qacc_application/widgets/section_header.dart';
import 'package:qacc_application/widgets/task_check_form.dart';

@RoutePage()
class SickLeaveRequest extends StatefulWidget {
  const SickLeaveRequest({super.key});

  @override
  State<SickLeaveRequest> createState() => _SickLeaveRequestState();
}

class _SickLeaveRequestState extends State<SickLeaveRequest> {
  final _formKey = GlobalKey<FormState>();
  late int employeeId;

  // متغير لتخزين مسار الملف المختار
  File? _file;
  String? _selectedFile; // المتغير لتمثيل الملف الذي تم اختياره
  bool isLoading = false;

  File? attachedMedicalFile;
  String? attachedMedicalFileName;

  bool isSubmitted = false; // لتتبع حالة الإرسال
  bool isSubmittedStateNo = false;

  String? _selectedOption = "نعم"; // القيمة المختارة

  // تعريف متغير للتحكم في تاريخ التكليف
  TextEditingController taskDateController = TextEditingController();
  // التحكم في حقل رقم الكتاب
  TextEditingController bookNumberController = TextEditingController();
  // التحكم في حقل المهمة
  TextEditingController taskController = TextEditingController();
  // التحكم في حقل الإدارة
  TextEditingController departmentController = TextEditingController();

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

  @override
  void initState() {
    super.initState();

    employeeId = Provider.of<EmployeeProvider>(context, listen: false)
        .employeeData!["id"];
  }

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
                  title: 'نموذج طلب إجازة مرضية',
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
                  child: Column(
                    children: [
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
                        title: 'إرفاق ملف طبي',
                        file: attachedMedicalFile,
                        openFilePicker: _openMedicalFilePicker,
                        onFilePicked: (file) {
                          setState(() {
                            attachedMedicalFile = file;
                          });
                        },
                        validator: (value) =>
                            attachedMedicalFile == null && isSubmittedStateNo
                                ? 'يرجى إرفاق ملف طبي'
                                : null,
                      ),

                      Gap(10.0),
                      isLoading
                          ? CircularProgressIndicator()
                          : LargeButton(
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

  // دالة لإرسال البيانات إلى API
  void _sendRequestToAPI(Map<String, dynamic> requestData) async {
    final url = "http://www.hr.qacc.ly/php/submit_sick_leave.php";
    setState(() => isLoading = true);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['employeeID'] = requestData['employee_id'];
      request.fields['leave_type'] = requestData['leave_type'];
      request.fields['isTasked'] = requestData['isTasked'];
      request.fields['days'] = requestData['days'];
      request.fields['request_date'] = requestData['request_date'];
      request.fields['start_date'] = requestData['start_date'];
      request.fields['end_date'] = requestData['end_date'];
      request.fields['resume_date'] = requestData['resume_date'];

      // أضف حقول التكليف فقط إذا كان الخيار "نعم"
      if (requestData['isTasked'] == "نعم") {
        request.fields['task_date'] = requestData['task_date'];
        request.fields['book_number'] = requestData['book_number'];
        request.fields['task'] = requestData['task'];
        request.fields['department'] = requestData['department'];
      }

      if (_file != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'pdf_file',
          _file!.path,
        ));
      }
      if (attachedMedicalFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'medical_certificate',
          attachedMedicalFile!.path,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsonResponse['message'],textAlign: TextAlign.right,),
            duration: Duration(seconds: 2),
            backgroundColor: jsonResponse['status'] == 'success' ? Colors.green : Colors.red,
          ),
        );
        _resetFields();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في إرسال الطلب'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ: $e'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
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
          'employee_id': employeeId.toString(), // إضافة employee_id لأنه مطلوب
          'leave_type': "اجازة مرضية",
          'isTasked': _selectedOption.toString(), // مطابق لـ API
          'task_date': taskDateController.text, // مطابق لـ API
          'book_number': bookNumberController.text, // مطابق لـ API
          'task': taskController.text, // مطابق لـ API
          'department': departmentController.text, // مطابق لـ API
          'days': daysController.text, // مطابق لـ API
          'request_date': requestDateController.text, // مطابق لـ API
          'start_date': leaveStartController.text, // مطابق لـ API
          'end_date': leaveEndController.text, // مطابق لـ API
          'resume_date': resumptionController.text, // مطابق لـ API
          'decision_file': _file, // مطابق لـ API
          'medical_certificate': attachedMedicalFile, // مطابق لـ API
        };

      _sendRequestToAPI(requestData);
      }
    } else if (_selectedOption == "لا") {
      // إذا تم اختيار "نعم" فقط يتم التحقق من الحقول
      if (_formKey.currentState!.validate()) {
        if (attachedMedicalFile == null) {
          return; // إيقاف الإرسال إذا كان الملف الطبي فارغًا
        }
        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          'employee_id': employeeId.toString(), // إضافة employee_id
          'leave_type': "اجازة مرضية",
          'isTasked': _selectedOption.toString(), // مطابق لـ API
          'days': daysController.text, // مطابق لـ API
          'request_date': requestDateController.text, // مطابق لـ API
          'start_date': leaveStartController.text, // مطابق لـ API
          'end_date': leaveEndController.text, // مطابق لـ API
          'resume_date': resumptionController.text, // مطابق لـ API
          'medical_certificate': attachedMedicalFile, // مطابق لـ API
        };

         _sendRequestToAPI(requestData);

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

