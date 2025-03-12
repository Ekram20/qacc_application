import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/date_form_field.dart';

class DateFormFieldWidgetFS extends StatefulWidget {
  final int days;
  final TextEditingController requestDateController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController resumeDateController;

  const DateFormFieldWidgetFS({
    super.key,
    required this.days,
    required this.requestDateController,
    required this.startDateController,
    required this.endDateController,
    required this.resumeDateController,
  });

  @override
  _DateFormFieldWidgetFSState createState() => _DateFormFieldWidgetFSState();
}

class _DateFormFieldWidgetFSState extends State<DateFormFieldWidgetFS> {
  final DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // تعيين تاريخ الطلب تلقائيًا
    widget.requestDateController.text = DateFormat('yyyy-MM-dd').format(currentDate);
    // استماع لتغيير تاريخ نهاية الإجازة لحساب تاريخ المباشرة
    widget.endDateController.addListener(calculateResumeDate);
  }

  void calculateEndDate() {
    if (widget.days <= 0 || widget.startDateController.text.isEmpty) {
      widget.endDateController.text = '';
      return;
    }

    DateTime? startDate = DateTime.tryParse(widget.startDateController.text);
    if (startDate == null) {
      widget.endDateController.text = '';
      return;
    }

    DateTime tempDate = startDate;
    int addedDays = 0;

    // إضافة الأيام مع تجاوز الجمعة والسبت
    while (addedDays < widget.days) {
      tempDate = tempDate.add(const Duration(days: 1));
      if (tempDate.weekday != DateTime.friday && tempDate.weekday != DateTime.saturday) {
        addedDays++;
      }
    }

    setState(() {
      widget.endDateController.text = DateFormat('yyyy-MM-dd').format(tempDate);
    });
  }

  void calculateResumeDate() {
    if (widget.endDateController.text.isEmpty) {
      widget.resumeDateController.text = '';
      return;
    }

    DateTime? endDate = DateTime.tryParse(widget.endDateController.text);
    if (endDate == null) {
      widget.resumeDateController.text = '';
      return;
    }

    DateTime tempDate = endDate;

    // تجاوز يومي الجمعة والسبت
    do {
      tempDate = tempDate.add(const Duration(days: 1));
    } while (tempDate.weekday == DateTime.friday || tempDate.weekday == DateTime.saturday);

    setState(() {
      widget.resumeDateController.text = DateFormat('yyyy-MM-dd').format(tempDate);
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
        widget.startDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        calculateEndDate(); // حساب تاريخ نهاية الإجازة تلقائيًا
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateFormField(
          controller: widget.requestDateController,
          readOnly: true,
          labelText: 'تاريخ الطلب',
          onDateSelected: (date) {},
        ),
        const SizedBox(height: 16),
        DateFormField(
          controller: widget.startDateController,
          labelText: 'تاريخ بدء الإجازة',
          validator: (value) => value == null || value.isEmpty ? 'يرجى إدخال تاريخ بدء الإجازة' : null,
          onDateSelected: (date) {
            widget.startDateController.text = DateFormat('yyyy-MM-dd').format(date!);
            calculateEndDate(); // حساب تاريخ نهاية الإجازة تلقائيًا
          },
        ),
        const SizedBox(height: 16),
        DateFormField(
          controller: widget.endDateController,
          readOnly: true,
          labelText: 'تاريخ نهاية الإجازة',
          onDateSelected: (date) {},
        ),
        const SizedBox(height: 16),
        DateFormField(
          controller: widget.resumeDateController,
          readOnly: true,
          labelText: 'تاريخ المباشرة',
          onDateSelected: (date) {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.requestDateController.dispose();
    widget.startDateController.dispose();
    widget.endDateController.dispose();
    widget.resumeDateController.dispose();
    super.dispose();
  }
}
