import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/widgets/custom_text_field.dart';
import 'package:qacc_application/widgets/section_header.dart';

import '../widgets/large_button.dart';

@RoutePage()
class ItemsOrderPage extends StatefulWidget {
  const ItemsOrderPage({super.key});

  @override
  State<ItemsOrderPage> createState() => _ItemsOrderPageState();
}

class _ItemsOrderPageState extends State<ItemsOrderPage> {
  final _employeeName = TextEditingController();
  final _entityName = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _items = [
    {'id': UniqueKey().toString(), 'item': '', 'quantity': 0}
  ]; // صنف مبدئي

  void _addItem() {
    setState(() {
      _items.add({'id': UniqueKey().toString(), 'item': '', 'quantity': 0});
    });
  }

  void _removeItem(String id) {
    setState(() {
      if (_items.length > 1) {
        _items.removeWhere((item) => item['id'] == id);
      } else {
      _showSnackBar('لا يمكن حذف جميع الأصناف. يجب أن يحتوي النموذج على صنف واحد على الأقل.');

      }
    });
  }

    void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // تجميع البيانات للإرسال
      List<Map<String, dynamic>> dataToSave = [];

      // الحصول على قيمة اسم الموظف و الكيان
      String employeeName = _employeeName.text; // ضع هنا الكود لجلب اسم الموظف
      String entityName = _entityName.text; // ضع هنا الكود لجلب الكيان

      for (var item in _items) {
        dataToSave.add({
          'item': item['item'],
          'quantity': item['quantity'],
        });
      }

      // إضافة الاسم والكيان إلى البيانات
      Map<String, dynamic> requestData = {
        'employeeName': employeeName,
        'entityName': entityName,
        'items': dataToSave,
      };

      // هنا يمكنك استبدال هذا الجزء بكود الاتصال بقاعدة البيانات
      // على سبيل المثال: await database.save(requestData);

      // عرض رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إرسال طلبك بنجاح: $requestData'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
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
                SectionHeader(title: 'نموذج طلب أصناف'),
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Gap(10),
                      CustomTextField(
                        controller: _employeeName,
                        labelText: 'اسم الموظف',
                        icon: Icons.account_circle,
                        validator: (value) =>
                            value!.isEmpty ? 'يرجى إدخال اسم الموظف' : null,
                      ),
                      Gap(10),
                      CustomTextField(
                        controller: _entityName,
                        labelText: 'الكيان',
                        icon: Icons.apartment,
                        validator: (value) => value!.isEmpty
                            ? 'يرجى إدخال الكيان التابع له'
                            : null,
                      ),
                      Gap(10),
                      ..._items.map((item) {
                        return Column(
                          key: Key(item['id']), // مفتاح فريد لكل عنصر
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // محاذاة العناصر في المنتصف
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: CustomTextField(
                                    labelText: 'الصنف المطلوب',
                                    icon: Icons.view_list,
                                    onChanged: (value) => item['item'] = value,
                                    validator: (value) => value!.isEmpty
                                        ? 'يرجى إدخال الصنف'
                                        : null,
                                  ),
                                ),
                                Gap(10.0),
                                Expanded(
                                  flex: 2,
                                  child: CustomTextField(
                                    labelText: 'الكمية',
                                    icon: Icons.add_shopping_cart,
                                    onChanged: (value) => item['quantity'] =
                                        int.tryParse(value) ?? 0,
                                    validator: (value) => value!.isEmpty
                                        ? 'يرجى إدخال الكمية'
                                        : null,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove_circle,
                                      color: Colors.red),
                                  onPressed: () => _removeItem(item['id']),
                                ),
                              ],
                            ),
                            Gap(10.0),
                          ],
                        );
                      }).toList(),
                      LargeButton(
                        buttonText:"إضافة صنف أخر" ,
                        color: AppColors.secondaryColor.shade600,
                        onPressed:_addItem,
                      )
                      // Container(
                      //   color: AppColors.secondaryColor.shade600,
                      //   width: double.infinity,
                      //   child: MaterialButton(
                      //     onPressed: _addItem,
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(16.0),
                      //       child: Text('إضافة صنف أخر',
                      //           style: Theme.of(context).textTheme.bodySmall),
                      //     ),
                      //   ),
                      // ),
                      //
                    ],
                  ),
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
}
