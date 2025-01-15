import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
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
    bool isSubmitted = false;  // لتتبع حالة الإرسال


  String? _selectedOption = "نعم"; // القيمة المختارة
  String? _selectedFile; // المتغير لتمثيل الملف الذي تم اختياره
  DateTime? _taskDate;
  TextEditingController _controller = TextEditingController();
  // التحكم في الحقول الإضافية
  TextEditingController _bookNumberController = TextEditingController();
  TextEditingController _taskController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();

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
                  taskDate: _taskDate,
                  controller: _controller,
                  file: _file,
                  openFilePicker: _openFilePicker,
                  dateValidator: (value) =>
                      value!.isEmpty ? 'يرجى إدخال تاريخ التكليف' : null,
                  pdfValidator: (value) =>
                      _file == null && isSubmitted ? 'يرجى إرفاق ملف PDF' : null, // تحقق من الملف فقط عند الإرسال
                  onFilePicked: (file) {
                    setState(() {
                      _file = file;
                    });
                  },
                  onDateSelected: (date) {
                    setState(() {
                      _taskDate = date;
                      _controller.text =
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
],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: AppColors.secondaryColor.shade600,
        width: double.infinity,
        child: MaterialButton(
          onPressed: _submitForm,
          child:
              Text('إرسال الطلب', style: Theme.of(context).textTheme.bodySmall),
        ),
      ),
    );
  }

void _submitForm() {
      setState(() {
      isSubmitted = true;  // تعيين حالة الإرسال إلى true
    });
  if (_selectedOption == "نعم") {
    // إذا تم اختيار "نعم" فقط يتم التحقق من الحقول
    if (_formKey.currentState!.validate()) {
      // إضافة البيانات إلى الكائن requestData
      Map<String, dynamic> requestData = {
        '_selectedOption': _selectedOption,
        '_taskDate': _taskDate,
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
