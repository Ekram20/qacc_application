import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/widgets/custom_text_field.dart';
import 'package:qacc_application/widgets/date_form_field_widget.dart';
import 'package:qacc_application/widgets/large_button.dart';
import 'package:qacc_application/widgets/leave_reason_field.dart';
import 'package:qacc_application/widgets/pdf_widget.dart';
import 'package:qacc_application/widgets/section_header.dart';
import '../widgets/circularProgressIndicator.dart';

import '../providers/employee_provider.dart';

@RoutePage()
class EmergencyLeaveRequest extends StatefulWidget {
  const EmergencyLeaveRequest({super.key});

  @override
  State<EmergencyLeaveRequest> createState() => _EmergencyLeaveRequestState();
}

class _EmergencyLeaveRequestState extends State<EmergencyLeaveRequest> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  File? _file;
  String? _selectedFile; // المتغير لتمثيل الملف الذي تم اختياره

  bool isSubmitted = false; // لتتبع حالة الإرسال

  bool isSubmittedStateNo = false;
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

  //عدد الايام المسموح بها
  TextEditingController _leaveController = TextEditingController();

  late int employeeId;
  bool _isLoading = true;
  Timer? _timer; // لتعريف المؤقت

  @override
  void initState() {
    super.initState();

    final employeeData =
        Provider.of<EmployeeProvider>(context, listen: false).employeeData;

    _leaveController.text =
        employeeData?["emergency_leave_balance"].toString() ?? "";
    employeeId = employeeData?["id"] ?? 0;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getLeaveBalance();
    });
  }

  void getLeaveBalance() async {
    final id = Provider.of<EmployeeProvider>(context, listen: false)
        .employeeData?['id'];
    if (id == null) return;

    try {
      final res = await http.get(
          Uri.parse('http://www.hr.qacc.ly/php/get_employee_data.php?id=$id'));
      final data = jsonDecode(res.body);
      if (data['success']) {
        // تحديث البيانات في الـ Provider
        Provider.of<EmployeeProvider>(context, listen: false)
            .updateEmployeeData(data['employee']);
        setState(() {
          _leaveController.text =
              data['employee']['emergency_leave_balance'].toString();
        });
      }
    } catch (e) {
      print('خطأ أثناء الجلب: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // لا تنسى إيقاف المؤقت عند مغادرة الشاشة
    super.dispose();
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
                          setState(() {
                            int enteredDays = int.tryParse(value) ?? 0;
                            int allowedDays =
                                int.tryParse(_leaveController.text) ?? 0;

                            if (enteredDays > 3) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'لا يمكن تجاوز 3 أيام في كل طلب',
                                    textAlign: TextAlign.right,
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              daysController.clear();
                            } else if (enteredDays > allowedDays) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'رصيد إجازتك لا يسمح بعدد الأيام المدخل',
                                    textAlign: TextAlign.right,
                                  ),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              daysController.clear();
                            }
                          });
                          setState(() {});
                        },
                      ),
                      Gap(16.0), // مسافة بين الحقول
                      // حقل عدد الأيام المسموح بها
                      CustomTextField(
                        controller: _leaveController,
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        labelText: 'عدد الأيام المسموح بها',
                        icon: Icons.pin_rounded,
                      ),
                      Gap(16.0),
                      LeaveReasonField(
                        controller: leaveReasonController,
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
                        title: 'إرفاق ملف (اختياري)',
                        file: _file,
                        openFilePicker: _openFilePicker,
                        onFilePicked: (file) {
                          setState(() {
                            _file = file;
                          });
                        },
                        validator: (value) => null, // الملف اختياري الآن
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
      var uri =
          Uri.parse("http://www.hr.qacc.ly/php/submit_Emergency_leave.php");

      setState(() => isLoading = true);

      var request = http.MultipartRequest("POST", uri);

      // إضافة البيانات كحقول نصية
      request.fields['employee_id'] = employeeId.toString();
      request.fields['leave_type'] = "اجازة طارئة";
      request.fields['days'] = daysController.text;
      request.fields['leave_reason'] = leaveReasonController.text;
      request.fields['request_date'] = requestDateController.text;
      request.fields['start_date'] = leaveStartController.text;
      request.fields['end_date'] = leaveEndController.text;
      request.fields['resume_date'] = resumptionController.text;

      // إضافة الملف إذا كان موجودًا
      if (_file != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'emergency_leave_file',
          _file!.path,
        ));
      }

      try {
        var response = await request.send();
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);

        if (response.statusCode == 200 && jsonResponse['status'] == "success") {
          // إعادة تعيين الحقول بعد الإرسال الناجح
          setState(() {
            daysController.clear();
            leaveReasonController.clear();
            leaveStartController.clear();
            leaveEndController.clear();
            resumptionController.clear();
            _file = null;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'تم إرسال طلبك لمديرك المباشر',
                textAlign: TextAlign.right,
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          print("خطأ: ${jsonResponse['message']}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطأ في الإرسال: ${jsonResponse['message']}'),
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
        setState(
            () => isLoading = false); // تغيير isLoading بعد الانتهاء من الإرسال
      }
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
