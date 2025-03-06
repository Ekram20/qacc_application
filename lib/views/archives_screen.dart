import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/models/message_model.dart';
import 'package:http/http.dart' as http;
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/widgets/message_bubble.dart';

class ArchivesScreen extends StatefulWidget {
  const ArchivesScreen({super.key});

  @override
  State<ArchivesScreen> createState() => _ArchivesScreenState();
}

class _ArchivesScreenState extends State<ArchivesScreen> {
  late int employeeId; // معرف الموظف الذي قام بتسجيل الدخول

  late Future<List<dynamic>> _messagesFuture;

  @override
  void initState() {
    super.initState();
    final employeeData =
        Provider.of<EmployeeProvider>(context, listen: false).employeeData;
    employeeId = employeeData!["id"];
    _messagesFuture = fetchMessages();
    print('............................///////${employeeId}');
  }

  Future<List<dynamic>> fetchMessages() async {
    final url = Uri.parse('http://www.hr.qacc.ly/php/messages_app_api.php?employee_id=${employeeId}'); // استبدل برابط API الحقيقي
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body); // تحويل البيانات إلى قائمة ديناميكية
    } else {
      throw Exception('فشل في تحميل الرسائل');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('المحفوظات', style: Theme.of(context).textTheme.bodySmall),
          centerTitle: true,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder<List<dynamic>>(
            future: _messagesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('حدث خطأ أثناء تحميل الرسائل'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('لا يوجد لديك رسائل بعد'));
              } else {
                final messages = snapshot.data!;
                return ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageBubble(message: message);
                  },
                );
              }
            },
          ),
        ));
  }
}
