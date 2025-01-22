import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/widgets/note_box.dart';
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

  File? attachedMarriageFile;
  String? _attachedMarriageFileName;
  bool isSubmittedStateNo = false;


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
                  onImageTap: () {},
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
                      const Gap(20),
                      LargeButton(
                        buttonText: 'إرسال الطلب',
                        onPressed: _submitForm,
                        color: AppColors.primaryColor,
                      ),
                      Gap(20)
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

        // عرض رسالة نجاح بعد إرسال البيانات
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم إرسال البيانات بنجاح: $requestData'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        _resetFields(); // إعادة تعيين الحقول
      }
    } else if (_selectedOption == "لا") {
      // إذا تم اختيار "لا" فقط يتم التحقق من الحقول
      if (_formKey.currentState!.validate()) {
        if (attachedMarriageFile == null) {
          return; // إيقاف الإرسال إذا كان الملف الطبي فارغًا
        }
        // إضافة البيانات إلى الكائن requestData
        Map<String, dynamic> requestData = {
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

        // عرض رسالة نجاح بعد إرسال البيانات
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
