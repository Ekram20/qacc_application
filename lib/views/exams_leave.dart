//نموذج إجازة إمتحانات
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../models/app_colors.dart';
import '../widgets/large_button.dart';
import '../widgets/section_header.dart';
@RoutePage()
class ExamsLeave extends StatefulWidget {
  const ExamsLeave({super.key});

  @override
  State<ExamsLeave> createState() => _ExamsLeaveState();
}

class _ExamsLeaveState extends State<ExamsLeave> {
  final _formKey = GlobalKey<FormState>();

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
                  title: 'طلب إجازة إمتحانات',
                  image: 'assets/images/Info.png',
                  onImageTap: () {},
                ),
                const Gap(10),

                // TaskCheckForm(
                //   pdfTitle: 'إرفاق صورة من كتاب او قرار التكليف',
                //   selectedOption: _selectedOption,
                //   onOptionChanged: (value) {
                //     setState(() {
                //       _selectedOption = value;
                //       isSubmitted = false;
                //       _file = null;
                //     });
                //   },
                //   labelDateText: 'تاريخ التكليف ',
                //   controller: taskDateController,
                //   file: _file,
                //   openFilePicker: _openFilePicker,
                //   dateValidator: (value) =>
                //   value!.isEmpty ? 'يرجى إدخال تاريخ التكليف' : null,
                //   pdfValidator: (value) => _file == null && isSubmitted
                //       ? 'يرجى إرفاق ملف PDF'
                //       : null,
                //   onFilePicked: (file) {
                //     setState(() {
                //       _file = file;
                //     });
                //   },
                //   onDateSelected: (date) {
                //     setState(() {
                //       taskDateController.text =
                //       "${date.year}-${date.month}-${date.day}";
                //     });
                //   },
                //   bookNumberController: bookNumberController,
                //   bookNumberValidator: (value) =>
                //   value!.isEmpty ? 'يرجى إدخال رقم الكتاب' : null,
                //   taskController: taskController,
                //   taskValidator: (value) =>
                //   value!.isEmpty ? 'يرجى إدخال المهمة' : null,
                //   departmentController: departmentController,
                //   departmentValidator: (value) =>
                //   value!.isEmpty ? 'يرجى إدخال اسم الإدارة' : null,
                // ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      // DateFormFieldWidget(
                      //   days: 14,
                      //   requestDateController: requestDateController,
                      //   startDateController: startDateController,
                      //   endDateController: endDateController,
                      //   resumeDateController: resumeDateController,
                      // ),
                      const Gap(20),
                      LargeButton(
                        buttonText: 'إرسال الطلب',
                        //onPressed: _submitForm,
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
}
