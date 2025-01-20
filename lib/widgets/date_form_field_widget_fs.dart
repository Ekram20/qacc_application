import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qacc_application/models/app_colors.dart';
import '../widgets/section_header.dart';
import '../widgets/date_form_field.dart';

class DateFormFieldWidgetFS extends StatefulWidget {
  final int days;

  const DateFormFieldWidgetFS({super.key, required this.days});

  @override
  _DateFormFieldWidgetFSState createState() => _DateFormFieldWidgetFSState();
}

class _DateFormFieldWidgetFSState extends State<DateFormFieldWidgetFS> {
  final TextEditingController requestDateController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController resumeDateController = TextEditingController();
  final DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // تعبئة التاريخ الحالي في حقل تاريخ الطلب
    requestDateController.text = DateFormat('yyyy-MM-dd').format(currentDate);
    // استماع لتغييرات تاريخ نهاية الإجازة لتحديث تاريخ المباشرة
    endDateController.addListener(calculateResumeDate);
  }

  void calculateEndDate() {
    if (widget.days <= 0 || startDateController.text.isEmpty) {
      setState(() {
        endDateController.text = '';
      });
      return;
    }

    DateTime? startDate = DateTime.tryParse(startDateController.text);
    if (startDate == null) {
      setState(() {
        endDateController.text = '';
      });
      return;
    }

    DateTime tempDate = startDate;
    int addedDays = 0;

    // إضافة عدد الأيام مع تجاوز أيام الجمعة والسبت
    while (addedDays < widget.days) {
      tempDate = tempDate.add(const Duration(days: 1));
      if (tempDate.weekday != DateTime.friday &&
          tempDate.weekday != DateTime.saturday) {
        addedDays++;
      }
    }

    setState(() {
      endDateController.text = DateFormat('yyyy-MM-dd').format(tempDate);
    });
  }

  void calculateResumeDate() {
    DateTime? endDate = DateTime.tryParse(endDateController.text);
    if (endDate == null) {
      setState(() {
        resumeDateController.text = '';
      });
      return;
    }

    DateTime tempDate = endDate;
    do {
      tempDate = tempDate.add(const Duration(days: 1));
    } while (tempDate.weekday == DateTime.friday ||
        tempDate.weekday == DateTime.saturday);

    setState(() {
      resumeDateController.text = DateFormat('yyyy-MM-dd').format(tempDate);
    });
  }

  Future<void> pickStartDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        startDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        calculateEndDate(); // تحديث تاريخ نهاية الإجازة
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'إجازة زواج'),
        const SizedBox(height: 16),
        // حقل تاريخ الطلب
        DateFormField(
          controller: requestDateController,
          readOnly: true,
          labelText: 'تاريخ الطلب',
          onDateSelected: (date) {},
        ),
        const SizedBox(height: 16),
        // حقل تاريخ بدء الإجازة
        DateFormField(
          controller: startDateController,
          labelText: 'تاريخ بدء الإجازة',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'يرجى إدخال تاريخ بدء الإجازة';
            }
            return null;
          },
          onDateSelected: (date) {
            startDateController.text = DateFormat('yyyy-MM-dd').format(date!);
            calculateEndDate(); // تحديث تاريخ نهاية الإجازة
          },
        ),
        const SizedBox(height: 16),
        // حقل تاريخ نهاية الإجازة
        DateFormField(
          controller: endDateController,
          readOnly: true,
          labelText: 'تاريخ نهاية الإجازة',
          onDateSelected: (date) {},
        ),
        const SizedBox(height: 16),
        // حقل تاريخ المباشرة
        DateFormField(
          controller: resumeDateController,
          readOnly: true,
          labelText: 'تاريخ المباشرة',
          onDateSelected: (date) {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    requestDateController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    resumeDateController.dispose();
    super.dispose();
  }
}
