import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/router/app_router.gr.dart';
import 'package:qacc_application/widgets/note_box.dart';
import '../widgets/circularProgressIndicator.dart';
import '../widgets/date_form_field_widget.dart';
import '../widgets/pdf_widget.dart';
import '../widgets/section_header.dart';
import '../widgets/large_button.dart';
import '../widgets/task_check_form.dart';

@RoutePage()
class MarriageLeavePage extends StatefulWidget {
  const MarriageLeavePage({Key? key}) : super(key: key);

  @override
  State<MarriageLeavePage> createState() => _MarriageLeavePageState();
}

class _MarriageLeavePageState extends State<MarriageLeavePage> {
    // تعريف متغير للتحكم في عدد الأيام
  TextEditingController daysController = TextEditingController(text: (14).toString());

  final TextEditingController requestDateController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController resumeDateController = TextEditingController();
  final TextEditingController taskDateController = TextEditingController();
  final TextEditingController bookNumberController = TextEditingController();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _selectedOption = "نعم";

  bool isSubmitted = false;
  File? _file;
  late int employeeId;
  bool isLoading = false;

  File? attachedMarriageFile;
  String? _attachedMarriageFileName;
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
                Gap(20),
                SectionHeader(
                  title: 'طلب إجازة زواج',
                  image: 'assets/images/Info.png',
                  onImageTap: () {
                    context.router.push(MarriageLeaveInfoRoute());
                  },
                ),
                const Gap(20),
                NoteBox(
                  firstNote: "مدة هذه الإجازة اسبوعان",
                  secondNotes: "تمنح هذه الاجازة مرة واحدة فقط",
                ),
                TaskCheckForm(
                  pdfTitle: 'إرفاق صورة من كتاب او قرار التكليف',
                  selectedOption: _selectedOption,
                  onOptionChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                      isSubmitted = false;
                      _file = null;
                    });
                  },
                  labelDateText: 'تاريخ التكليف ',
                  controller: taskDateController,
                  file: _file,
                  openFilePicker: _openFilePicker,
                  dateValidator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال تاريخ التكليف' : null,
                  pdfValidator: (value) => _file == null && isSubmitted
                      ? 'يرجى إرفاق ملف PDF'
                      : null,
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
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      DateFormFieldWidget(
                        days: 14,
                        requestDateController: requestDateController,
                        startDateController: startDateController,
                        endDateController: endDateController,
                        resumeDateController: resumeDateController,
                      ),
                      Gap(15),
                      PdfWidget(
                        title: 'إرفاق صورة من وثيقة الزواج',
                        file: attachedMarriageFile,
                        openFilePicker: _openMarriageFilePicker,
                        onFilePicked: (file) {
                          setState(() {
                            attachedMarriageFile = file;
                          });
                        },
                        validator: (value) =>
                            attachedMarriageFile == null && isSubmittedStateNo
                                ? 'يرجى إرفاق صورة من وثيقة الزواج '
                                : null,
                      ),
                      Gap(10.0),
                      isLoading
                          ? CustomLoadingIndicator()
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

  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  // دالة لإرسال البيانات إلى API
  void _sendRequestToAPI(Map<String, dynamic> requestData) async {
    final url = "https://hr.qacc.ly/php/submit_marriage_leave.php";
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
      if (attachedMarriageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'marriage_certificate',
          attachedMarriageFile!.path,
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
        if (attachedMarriageFile == null) {
          return; // إيقاف الإرسال إذا كان الملف الطبي فارغًا
        }
        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          'employee_id': employeeId.toString(),
          'isTasked': _selectedOption.toString(),
          'leave_type': "اجازة الزواج",
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
          'marriage_certificate': attachedMarriageFile,
        };

        _sendRequestToAPI(requestData);
      }
    } else if (_selectedOption == "لا") {
      // إذا تم اختيار "لا" فقط يتم التحقق من الحقول
      if (_formKey.currentState!.validate()) {
        if (attachedMarriageFile == null) {
          return; // إيقاف الإرسال إذا كان الملف الطبي فارغًا
        }
        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          'employee_id': employeeId.toString(),
          'isTasked': _selectedOption.toString(),
          'leave_type': "اجازة الزواج",
          'task_date': taskDateController.text,
          'days': daysController.text,
          'request_date': requestDateController.text,
          'start_date': startDateController.text,
          'end_date': endDateController.text,
          'resume_date': resumeDateController.text,
          'marriage_certificate': attachedMarriageFile,
        };

        _sendRequestToAPI(requestData);
      }
    }
  }

  void _resetFields() {
    setState(() {
      startDateController.clear();
      endDateController.clear();
      resumeDateController.clear();
      taskDateController.clear();
      bookNumberController.clear();
      taskController.clear();
      departmentController.clear();
      _file = null;
      _selectedOption = "نعم";
      isSubmitted = false;
      isSubmittedStateNo = false;
      attachedMarriageFile = null;
    });
  }

  // فتح نافذة لاختيار الملف وثيقة الزواج
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
