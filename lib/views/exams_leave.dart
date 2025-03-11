import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/providers/employee_provider.dart';

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
    late int employeeId;
  bool isLoading = false;


  File? attachedExamFile;
  String? _attachedExamFileName;
  bool isSubmittedStateNo = false;

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
                        title: 'يرجى إرفاق جدول الإمتحانات و ورقة تنزيل المواد ',
                        file: attachedExamFile,
                        openFilePicker: _openExamFilePicker,
                        onFilePicked: (file) {
                          setState(() {
                            attachedExamFile = file;
                          });
                        },
                        validator: (value) =>
                        attachedExamFile == null && isSubmittedStateNo
                            ? 'يرجى إرفاق جدول الإمتحانات و ورقة تنزيل المواد '
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

    // دالة لإرسال البيانات إلى API
  void _sendRequestToAPI(Map<String, dynamic> requestData) async {
    final url = "http://www.hr.qacc.ly/php/submit_exams_leave.php";
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
      if (attachedExamFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'exam_schedule_file',
          attachedExamFile!.path,
        ));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonResponse['message'],
              textAlign: TextAlign.right,
            ),
            duration: Duration(seconds: 2),
            backgroundColor:
                jsonResponse['status'] == 'success' ? Colors.green : Colors.red,
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
        if (attachedExamFile == null) {
          return; // إيقاف الإرسال إذا كان الملف الطبي فارغًا
        }
        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          'employee_id': employeeId.toString(),
          'isTasked': _selectedOption.toString(),
          'leave_type': "اجازة الإمتحانات",
          'task_date': taskDateController.text,
          'decision_file': _file,
          'book_number': bookNumberController.text,
          'task': taskController.text,
          'department': departmentController.text,
          'days': daysController.text,
          'request_date': requestDateController.text,
          'start_date': startDateController.text,
          'end_date': endDateController.text,
          'resume_date': resumeDateController.text,
          'exam_schedule_file': attachedExamFile,
        };

        _sendRequestToAPI(requestData);
      }
    } else if (_selectedOption == "لا") {
      // إذا تم اختيار "لا" فقط يتم التحقق من الحقول
      if (_formKey.currentState!.validate()) {
        if (attachedExamFile == null) {
          return; // إيقاف الإرسال إذا كان الملف الطبي فارغًا
        }
        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          'employee_id': employeeId.toString(),
          'isTasked': _selectedOption.toString(),
          'leave_type': "اجازة الإمتحانات",
          'task_date': taskDateController.text,
          'days': daysController.text,
          'request_date': requestDateController.text,
          'start_date': startDateController.text,
          'end_date': endDateController.text,
          'resume_date': resumeDateController.text,
          'exam_schedule_file': attachedExamFile,
        };

        _sendRequestToAPI(requestData);
      }
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
      attachedExamFile = null;
    });
  }

  // فتح نافذة لاختيار الملف وثيقة نتيجة الامتحان
  void _openExamFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _attachedExamFileName = result.files.single.name;
        attachedExamFile =
            File(result.files.single.path!); // حفظ المسار للملف الطبي
      });
    }
  }

}
