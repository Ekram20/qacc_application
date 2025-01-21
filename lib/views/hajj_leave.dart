import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:auto_route/auto_route.dart';
import '../models/app_colors.dart';
import '../widgets/date_form_field_widget.dart';
import '../widgets/large_button.dart';
import '../widgets/note_box.dart';
import '../widgets/section_header.dart';
import '../widgets/task_check_form.dart';

@RoutePage()
class HajjLeave extends StatefulWidget {
  const HajjLeave({super.key});

  @override
  State<HajjLeave> createState() => _HajjLeaveState();
}

class _HajjLeaveState extends State<HajjLeave> {
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
                  title: 'طلب إجازة حج',
                  image: 'assets/images/Info.png',
                  onImageTap: () {},
                ),
                const Gap(20),
                NoteBox(
                  firstNote: "مدة هذه الإجازة 20 يوم",
                  secondNotes: "تمنح هذه الاجازة مرة واحدة فقط",
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
                  pdfValidator: (value) => _file == null && isSubmitted
                      ? 'يرجى إرفاق ملف PDF'
                      : null,
                  dateValidator: (value) =>
                  value!.isEmpty ? 'يرجى إدخال تاريخ التكليف' : null,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      DateFormFieldWidget(
                        days: 20,
                        requestDateController: requestDateController,
                        startDateController: startDateController,
                        endDateController: endDateController,
                        resumeDateController: resumeDateController,
                      ),
                      const Gap(20),
                      LargeButton(
                        buttonText: 'إرسال الطلب',
                        color: AppColors.primaryColor,
                        onPressed: _submitForm,
                      ),
                      const Gap(20),
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

  /// دالة إرسال الطلب
  void _submitForm() {
    setState(() {
      isSubmitted = true;
    });

    if (_formKey.currentState!.validate() &&
        (_selectedOption != "نعم" || _file != null)) {
      final requestData = {
        'requestDate': requestDateController.text,
        'startDate': startDateController.text,
        'endDate': endDateController.text,
        'resumeDate': resumeDateController.text,
        'taskDate': taskDateController.text,
        'bookNumber': bookNumberController.text,
        'task': taskController.text,
        'department': departmentController.text,
        'fileAttached': _file != null,
      };

      // عرض رسالة النجاح
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("تم إرسال البيانات بنجاح."),
          backgroundColor: Colors.green,
        ),
      );

      // إعادة تعيين الحقول
      setState(() {
        requestDateController.clear();
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
      });
    } else {
      // عرض رسالة خطأ إذا كان هناك مشكلة في التحقق
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى التأكد من تعبئة جميع الحقول المطلوبة."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
