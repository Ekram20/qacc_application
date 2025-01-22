import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:auto_route/auto_route.dart';
import '../models/app_colors.dart';
import '../widgets/date_form_field_widget.dart';
import '../widgets/large_button.dart';
import '../widgets/note_box.dart';
import '../widgets/pdf_widget.dart';
import '../widgets/section_header.dart';
import '../widgets/task_check_form.dart';

@RoutePage()
class DeathLeave extends StatefulWidget {
  const DeathLeave({super.key});

  @override
  State<DeathLeave> createState() => _DeathLeaveState();
}

class _DeathLeaveState extends State<DeathLeave> {
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

  File? attachedDeathFile;
  String? _attachedDeathFileName;
  bool isSubmittedStateNo = false;

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
                        startDateController: startDateController,
                        endDateController: endDateController,
                        resumeDateController: resumeDateController,
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
                      const Gap(20),
                      LargeButton(
                        buttonText: 'إرسال الطلب',
                        onPressed: _submitForm,
                        color: AppColors.primaryColor,
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

  void _submitForm() {
    setState(() {
      isSubmittedStateNo = true; // تعيين حالة الإرسال إلى true
    });

    if (_selectedOption == "نعم") {
      setState(() {
        isSubmitted = true; // تعيين حالة الإرسال إلى true
      });

      // التحقق من الحقول عند اختيار "نعم"
      if (_formKey.currentState!.validate()) {
        // تحقق إضافي لضمان أن الملف موجود
        if (_file == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("يرجى إرفاق الملف عند اختيار 'نعم'."),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        if (attachedDeathFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("يرجى إرفاق شهادة الوفاة أو إذن الدفن."),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // إعداد البيانات للإرسال
        final requestData = {
          '_selectedOption': _selectedOption,
          'taskDate': taskDateController.text,
          '_file': _file,
          'bookNumber': bookNumberController.text,
          'task': taskController.text,
          'department': departmentController.text,
          'requestDate': requestDateController.text,
          'startDate': startDateController.text,
          'endDate': endDateController.text,
          'resumeDate': resumeDateController.text,
        };

        // عرض رسالة نجاح
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم إرسال البيانات بنجاح: $requestData'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        _resetFields(); // إعادة تعيين الحقول
      }
    } else if (_selectedOption == "لا") {
      // التحقق من الحقول عند اختيار "لا"
      if (_formKey.currentState!.validate()) {
        if (attachedDeathFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("يرجى إرفاق شهادة الوفاة أو إذن الدفن ."),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // إعداد البيانات للإرسال
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

        // عرض رسالة نجاح
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم إرسال البيانات بنجاح: $requestData'),
            backgroundColor: Colors.green,
          ),
        );
        _resetFields(); // إعادة تعيين الحقول
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
