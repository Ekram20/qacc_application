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
import 'dart:convert';
import 'package:http/http.dart' as http;


@RoutePage()
class AnnualLeaveRequest extends StatefulWidget {
  const AnnualLeaveRequest({super.key});

  @override
  State<AnnualLeaveRequest> createState() => _AnnualLeaveRequestState();
}

class _AnnualLeaveRequestState extends State<AnnualLeaveRequest> {
  final _formKey = GlobalKey<FormState>();

  // متغير لتخزين مسار الملف المختار
  File? _file ;
  bool isSubmitted = false ; // لتتبع حالة الإرسال

  String? _selectedOption = "نعم" ; // القيمة المختارة
  String? _selectedFile ; // المتغير لتمثيل الملف الذي تم اختياره

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

  String employeeId = "103";
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
                      Gap(16.0), // مسافة بين الحقول
                      DateFormFieldWidgetFS(
                        days: int.tryParse(daysController.text) ??
                            0, // تمرير حقل عدد الأيام
                        requestDateController:
                            requestDateController, // تمرير حقل تاريخ الطلب
                        startDateController:
                            leaveStartController, // تمرير حقل تاريخ بدء الإجازة
                        endDateController:
                            leaveEndController, // تمرير حقل تاريخ انتهاء الإجازة
                        resumeDateController:
                            resumptionController, // تمرير حقل تاريخ العودة
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



// تعديل دالة _submitForm داخل _AnnualLeaveRequestState:
  void _submitForm() async {
    if (_selectedOption == "نعم") {
      setState(() {
        isSubmitted = true;
      });
      if (_formKey.currentState!.validate()) {
        // التأكد من اختيار الملف عند اختيار "نعم"
        if (_selectedOption == "نعم" && _file == null) {
          return;
        }

        // إنشاء طلب Multipart
        Uri uri = Uri.parse("https://yourdomain.com/submit_annual_leave.php");
        var request = http.MultipartRequest('POST', uri);

        // إضافة الحقول النصية
        request.fields['employee_id']    = employeeId;
        request.fields['selected_option']  = _selectedOption!;
        request.fields['task_date']        = taskDateController.text;
        request.fields['book_number']      = bookNumberController.text;
        request.fields['task']             = taskController.text;
        request.fields['department']       = departmentController.text;
        request.fields['days']             = daysController.text;
        request.fields['request_date']     = requestDateController.text;
        request.fields['leave_start']      = leaveStartController.text;
        request.fields['leave_end']        = leaveEndController.text;
        request.fields['resumption']       = resumptionController.text;

        // إضافة الملف إذا كان موجود
        if (_file != null) {
          request.files.add(await http.MultipartFile.fromPath('pdf_file', _file!.path));
        }

        // إرسال الطلب
        var response = await request.send();
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);

        if (jsonResponse["success"]) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم حفظ البيانات بنجاح'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
          _resetFields();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطأ: ${jsonResponse["message"]}'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else if (_selectedOption == "لا") {
      if (_formKey.currentState!.validate()) {
        Uri uri = Uri.parse("https://hr.qacc.ly/php/submit_annual_leave.php");
        var request = http.MultipartRequest('POST', uri);

        request.fields['employee_id']    = employeeId;
        request.fields['selected_option']  = _selectedOption!;
        request.fields['task_date']        = taskDateController.text;
        request.fields['book_number']      = bookNumberController.text;
        request.fields['task']             = taskController.text;
        request.fields['department']       = departmentController.text;
        request.fields['days']             = daysController.text;
        request.fields['request_date']     = requestDateController.text;
        request.fields['leave_start']      = leaveStartController.text;
        request.fields['leave_end']        = leaveEndController.text;
        request.fields['resumption']       = resumptionController.text;

        var response = await request.send();
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);

        if (jsonResponse["success"]) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم حفظ البيانات بنجاح'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
          _resetFields();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطأ: ${jsonResponse["message"]}'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

// دالة لإعادة تعيين الحقول
  void _resetFields() {
    setState(() {
      // إعادة تعيين قيم الحقول
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
      isSubmitted = false;
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
}
