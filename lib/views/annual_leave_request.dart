import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/router/app_router.gr.dart';
import 'package:qacc_application/widgets/custom_text_field.dart';
import 'package:qacc_application/widgets/date_form_field_widget_fs.dart';
import 'package:qacc_application/widgets/large_button.dart';
import 'package:qacc_application/widgets/section_header.dart';
import 'package:auto_route/auto_route.dart';
import 'package:qacc_application/widgets/task_check_form.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

@RoutePage()
class AnnualLeaveRequest extends StatefulWidget {
  const AnnualLeaveRequest({super.key});

  @override
  State<AnnualLeaveRequest> createState() => _AnnualLeaveRequestState();
}

class _AnnualLeaveRequestState extends State<AnnualLeaveRequest> {
  final _formKey = GlobalKey<FormState>();

  // متغير لتخزين مسار الملف المختار
  File? _file;
  bool isSubmitted = false; // لتتبع حالة الإرسال

  String? _selectedOption = "نعم"; // القيمة المختارة
  String? _selectedFile; // المتغير لتمثيل الملف الذي تم اختياره

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

  TextEditingController _leaveController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEmployeeLeave();
  }


  // دالة لجلب عدد الأيام المسموح بها من API
  Future<void> _fetchEmployeeLeave() async {
    final response = await http.get(Uri.parse(
        'https://hr.qacc.ly/php/get_employee_leave.php?employee_id=11'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          _leaveController.text = data['annual_leave'].toString();
          _isLoading = false;
        });
      } else {
        // التعامل مع الأخطاء إذا لم يتم العثور على الموظف
        setState(() {
          _leaveController.text = 'خطأ في جلب البيانات';
          _isLoading = false;
        });
      }
    } else {
      // في حالة حدوث خطأ في الاتصال
      setState(() {
        _leaveController.text = 'فشل في الاتصال';
        _isLoading = false;
      });
    }
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
                  title: 'نموذج طلب إجازة سنوية',
                  image: 'assets/images/Info.png',
                  onImageTap: () {
                    context.router.push(LeaveInfoRoute(
                      leaveName: 'الإجازة السنوية :',
                      leaveDuration:
                      'تكون الاجازة السنوية ثلاثين يوماً في السنة وخمسة واربعين يوماً لمن بلغ سن الخمسين سنة او تجاوزت مدة خدمته عشرون عاماً.',
                      procedureStepsTitle: 'خطوات اجراء الإجازة :',
                      stepDescription:
                      'تعبئة نموذج طلب الاجازة رقم (A2) من قبل الموظف ويقدم لرئيس المباشر',
                      stepOne:
                      'بعد موافقة الرئيس المباشرة على طلب الاجازة يعبنه النموذج رقم (B2) من جزئيين الجزء الاول من فبل الموظف والجزء الثاني من فبل الموظف المختص بالإجازات',
                      stepTwo:
                      'لا يعتبر الموظف قد تحصل على الاجازة الابعد اعتماد النموذج رقم (B2) من الرئيس المباشر والرئيس الاعلى للموظف',
                      stepThree:
                      'على الموظف تقدم على الإجازة فبل اسبوع من التاريخ المراد الحصول فيه على الاجازة',
                    ));
                  },
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
                          setState(() {
                            // تحقق من القيمة المدخلة إذا كانت أكبر من عدد الأيام المسموح بها
                            int enteredDays = int.tryParse(value) ?? 0;
                            int allowedDays = int.tryParse(_leaveController.text) ?? 0;

                            if (enteredDays > allowedDays) {
                              // إظهار الـ SnackBar مباشرة هنا
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('رصيد إجازتك لا يسمح بعدد الأيام المدخل.'),
                                  backgroundColor: Colors.red,  // يمكنك تغيير اللون حسب الحاجة
                                  duration: Duration(seconds: 3), // مدة ظهور الـ SnackBar
                                ),
                              );
                            }
                          });
                        },
                      ),

                      Gap(16.0), // مسافة بين الحقول

// حقل عدد الأيام المسموح بها
                      CustomTextField(
                        controller: _leaveController,
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        labelText:  'عدد الأيام المسموح بها',
                        icon: Icons.pin_rounded,
                      ),

                      Gap(16.0), // مسافة بين الحقول
                      DateFormFieldWidgetFS(
                        days: int.tryParse(daysController.text) ?? 0,
                        requestDateController: requestDateController,
                        startDateController: leaveStartController,
                        endDateController: leaveEndController,
                        resumeDateController: resumptionController,
                      ),
                      Gap(16.0),
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
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSubmitted = true;
      });

      try {
        var uri = Uri.parse("https://hr.qacc.ly/php/submit_annual_leave.php");
        var request = http.MultipartRequest("POST", uri);

        // تجهيز البيانات المشتركة بين الحالتين
        Map<String, String> formData = {
          "employeeID": "11",
          "leave_type": "اجازة سنوية",
          "isTasked": _selectedOption.toString(),
          "days": daysController.text,
          "request_date": requestDateController.text,
          "start_date": leaveStartController.text,
          "end_date": leaveEndController.text,
          "resume_date": resumptionController.text,
        };

        // إضافة الحقول المتعلقة بالتكليف فقط إذا كانت "نعم"
        if (_selectedOption == "نعم") {
          formData.addAll({
            "task_date": taskDateController.text,
            "book_number": bookNumberController.text,
            "task": taskController.text,
            "department": departmentController.text,
          });

          // التحقق من وجود الملف عند اختيار "نعم"
          if (_file == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("يرجى رفع ملف عند اختيار 'نعم'")),
            );
            return;
          }

          // إضافة الملف إلى الطلب
          request.files.add(await http.MultipartFile.fromPath(
            "pdf_file",
            _file!.path,
            contentType: MediaType("application", "pdf"),
          ));
        }

        // إضافة البيانات إلى الطلب
        request.fields.addAll(formData);

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم إرسال الطلب بنجاح")),
          );
          _resetFields();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("حدث خطأ أثناء إرسال الطلب")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("خطأ: ${e.toString()}")),
        );
      }
    }
  }


  void _resetFields() {
    setState(() {
      taskDateController.clear();
      bookNumberController.clear();
      taskController.clear();
      departmentController.clear();
      daysController.clear();
      //requestDateController.clear();
      leaveStartController.clear();
      leaveEndController.clear();
      resumptionController.clear();
      _file = null;
      isSubmitted = false;
    });
  }


  // فتح نافذة اختيار الملف
  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.single.name;
        _file = File(result.files.single.path!);
      });
    }
  }
}
