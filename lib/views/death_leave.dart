import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:auto_route/auto_route.dart';
import '../models/app_colors.dart';
import '../providers/employee_provider.dart';
import '../widgets/circularProgressIndicator.dart';
import '../widgets/date_form_field_widget.dart';
import '../widgets/large_button.dart';
import '../widgets/note_box.dart';
import '../widgets/pdf_widget.dart';
import '../widgets/section_header.dart';
import '../widgets/task_check_form.dart';
import 'package:provider/provider.dart';
@RoutePage()
class DeathLeave extends StatefulWidget {
  const DeathLeave({super.key});

  @override
  State<DeathLeave> createState() => _DeathLeaveState();
}

class _DeathLeaveState extends State<DeathLeave> {
  TextEditingController daysController = TextEditingController(text: (130).toString());
  final TextEditingController requestDateController = TextEditingController();
  final TextEditingController leaveStartController = TextEditingController();
  final TextEditingController leaveEndController = TextEditingController();
  final TextEditingController resumptionController = TextEditingController();
  final TextEditingController taskDateController = TextEditingController();
  final TextEditingController bookNumberController = TextEditingController();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _selectedOption = "نعم";
  bool isSubmitted = false;
  File? _file;

  File? attachedDeathFile;
  String? _attachedDeathFileName;
  bool isSubmittedStateNo = false;
  late int employeeId ;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    employeeId = Provider.of<EmployeeProvider>(context, listen: false)
        .employeeData!["id"];
  }
  /// دالة فتح منتقي الملفات
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
                  title: 'طلب إجازة وفاة',
                  image: 'assets/images/Info.png',
                  onImageTap: () {},
                ),
                const Gap(20),
                NoteBox(
                  firstNote: "مدة هذه الإجازة 4 أشهر و 10 أيام",
                  secondNotes: "تمنح هذه الاجازة مرة واحدة فقط",
                ),
                TaskCheckForm(
                  pdfTitle: 'إرفاق ملف اخلاء التكلييف',
                  selectedOption: _selectedOption,
                  onOptionChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                      isSubmitted = false;
                      _file = null;
                    });
                  },
                  labelDateText: 'تاريخ الوثيقة',
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
                  value!.isEmpty ? 'يرجى إدخال رقم الوثيقة' : null,
                  taskController: taskController,
                  taskValidator: (value) =>
                  value!.isEmpty ? 'يرجى إدخال المهمة' : null,
                  departmentController: departmentController,
                  departmentValidator: (value) =>
                  value!.isEmpty ? 'يرجى إدخال اسم الإدارة' : null,
                  pdfValidator: (value) => _file == null && isSubmitted
                      ? 'يرجى إرفاق ملف PDF'
                      : null,
                  dateValidator: (value) =>
                  value!.isEmpty ? 'يرجى إدخال تاريخ الوثيقة' : null,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      DateFormFieldWidget(
                        days: 130,
                        requestDateController: requestDateController,
                        startDateController: leaveStartController,
                        endDateController: leaveEndController,
                        resumeDateController: resumptionController,
                      ),
                      Gap(15),
                      PdfWidget(
                        title: 'إرفاق صورة من شهادة الوفاة أو إذن الدفن ',
                        file: attachedDeathFile,
                        openFilePicker: _openDeathFilePicker,
                        onFilePicked: (file) {
                          setState(() {
                            attachedDeathFile = file;
                          });
                        },
                        validator: (value) =>
                        attachedDeathFile == null && isSubmittedStateNo
                            ? 'يرجى إرفاق صورة من شهادة الوفاة او اذن الدفن '
                            : null,
                      ),
                      Gap(10.0),
                      isLoading
                          ? CustomLoadingIndicator(

                      )
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


  // دالة لإرسال البيانات إلى API
  void _sendRequestToAPI(Map<String, dynamic> requestData) async {
    final url = "https://hr.qacc.ly/php/submit_death_leave.php";
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
      if (attachedDeathFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'medical_certificate',
          attachedDeathFile!.path,
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
        if (attachedDeathFile == null) {
          return; // إيقاف الإرسال إذا كان الملف الطبي فارغًا
        }
        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          'employee_id': employeeId.toString(), // إضافة employee_id لأنه مطلوب
          'leave_type': "اجازة وفاة",
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
          'medical_certificate': attachedDeathFile, // مطابق لـ API
        };

        _sendRequestToAPI(requestData);
      }
    } else if (_selectedOption == "لا") {
      // إذا تم اختيار "نعم" فقط يتم التحقق من الحقول
      if (_formKey.currentState!.validate()) {
        if (attachedDeathFile == null) {
          return; // إيقاف الإرسال إذا كان الملف الطبي فارغًا
        }
        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
          'employee_id': employeeId.toString(), // إضافة employee_id
          'leave_type': "اجازة وفاة",
          'isTasked': _selectedOption.toString(), // مطابق لـ API
          'days': daysController.text, // مطابق لـ API
          'request_date': requestDateController.text, // مطابق لـ API
          'start_date': leaveStartController.text, // مطابق لـ API
          'end_date': leaveEndController.text, // مطابق لـ API
          'resume_date': resumptionController.text, // مطابق لـ API
          'medical_certificate': attachedDeathFile, // مطابق لـ API
        };

        _sendRequestToAPI(requestData);

      }
    }
  }

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


// دالة لإعادة تعيين الحقول
  void _resetFields() {
    setState(() {
      leaveStartController.clear();
      leaveEndController.clear();
      resumptionController.clear();
      taskDateController.clear();
      bookNumberController.clear();
      taskController.clear();
      departmentController.clear();
      _file = null;
      _selectedOption = "نعم";
      isSubmitted = false;
      isSubmittedStateNo = false;
      attachedDeathFile = null;
    });
  }

  void _openDeathFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _attachedDeathFileName = result.files.single.name;
        attachedDeathFile =
            File(result.files.single.path!); // حفظ المسار للملف الطبي
      });
    }
  }

}
