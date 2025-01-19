import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qacc_application/models/app_colors.dart';
import '../widgets/section_header.dart';
import '../widgets/date_form_field.dart';

class DateFormFieldWidget extends StatefulWidget {
  final int days;
  final TextEditingController requestDateController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController resumeDateController;

  const DateFormFieldWidget({
    Key? key,
    required this.days,
    required this.requestDateController,
    required this.startDateController,
    required this.endDateController,
    required this.resumeDateController,
  }) : super(key: key);

  @override
  _DateFormFieldWidgetState createState() => _DateFormFieldWidgetState();
}

class _DateFormFieldWidgetState extends State<DateFormFieldWidget> {
  final DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // تعبئة التاريخ الحالي في حقل تاريخ الطلب
    widget.requestDateController.text =
        DateFormat('yyyy-MM-dd').format(currentDate);
    // استماع لتغييرات تاريخ نهاية الإجازة لتحديث تاريخ المباشرة
    widget.endDateController.addListener(calculateResumeDate);
  }

  void calculateEndDate() {
    if (widget.days <= 0 || widget.startDateController.text.isEmpty) {
      setState(() {
        widget.endDateController.text = '';
      });
      return;
    }

    DateTime? startDate = DateTime.tryParse(widget.startDateController.text);
    if (startDate == null) {
      setState(() {
        widget.endDateController.text = '';
      });
      return;
    }

    // حساب تاريخ نهاية الإجازة بإضافة عدد الأيام
    DateTime tempDate = startDate.add(Duration(days: widget.days - 1));
    setState(() {
      widget.endDateController.text =
          DateFormat('yyyy-MM-dd').format(tempDate);
    });
  }

  void calculateResumeDate() {
    DateTime? endDate = DateTime.tryParse(widget.endDateController.text);
    if (endDate == null) {
      setState(() {
        widget.resumeDateController.text = '';
      });
      return;
    }

    // حساب تاريخ المباشرة
    DateTime tempDate = endDate.add(const Duration(days: 1));

    // إذا كان تاريخ نهاية الإجازة يوم خميس، تخطى يومي الجمعة والسبت
    if (endDate.weekday == DateTime.thursday) {
      tempDate = endDate.add(const Duration(days: 3));
    }

    // تحديث حقل تاريخ المباشرة
    setState(() {
      widget.resumeDateController.text =
          DateFormat('yyyy-MM-dd').format(tempDate);
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
        widget.startDateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
        calculateEndDate(); // تحديث تاريخ نهاية الإجازة
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // حقل تاريخ الطلب
        DateFormField(
          controller: widget.requestDateController,
          readOnly: true,
          labelText: 'تاريخ الطلب',
          onDateSelected: (date) {},
        ),
        const SizedBox(height: 16),
        // حقل تاريخ بدء الإجازة
        DateFormField(
          controller: widget.startDateController,
          labelText: 'تاريخ بدء الإجازة',
          onDateSelected: (date) {
            widget.startDateController.text =
                DateFormat('yyyy-MM-dd').format(date!);
            calculateEndDate(); // تحديث تاريخ نهاية الإجازة
          },
        ),
        const SizedBox(height: 16),
        // حقل تاريخ نهاية الإجازة
        DateFormField(
          controller: widget.endDateController,
          readOnly: true,
          labelText: 'تاريخ نهاية الإجازة',
          onDateSelected: (date) {},
        ),
        const SizedBox(height: 16),
        // حقل تاريخ المباشرة
        DateFormField(
          controller: widget.resumeDateController,
          readOnly: true,
          labelText: 'تاريخ المباشرة',
          onDateSelected: (date) {},
        ),
      ],
    );
  }
}
