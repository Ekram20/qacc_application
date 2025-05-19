import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/widgets/message_bubble.dart';

import '../widgets/circularProgressIndicator.dart';

class ArchivesScreen extends StatefulWidget {
  const ArchivesScreen({super.key});

  @override
  State<ArchivesScreen> createState() => _ArchivesScreenState();
}

class _ArchivesScreenState extends State<ArchivesScreen> {
  late int employeeId;
  List<dynamic> _messages = [];
  bool _isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    employeeId = Provider.of<EmployeeProvider>(context, listen: false).employeeData!["id"];
    fetchMessages(); // تحميل البيانات أول مرة
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      fetchMessages();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> fetchMessages() async {
    try {
      final url = Uri.parse('https://hr.qacc.ly/php/messages_app_api.php?employee_id=$employeeId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> newMessages = json.decode(response.body);

        if (!listEquals(newMessages, _messages)) {
          setState(() {
            _messages = newMessages;
          });
        }
      } else {
        throw Exception('فشل في تحميل الرسائل');
      }
    } catch (error) {
      print('خطأ أثناء جلب البيانات: $error');
    } finally {
      if (_isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المحفوظات', style: Theme.of(context).textTheme.bodySmall),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: _isLoading
            ? Center(child: CustomLoadingIndicator())
            : _messages.isEmpty
                ? Center(child: Text('لا يوجد لديك رسائل بعد'))
                : ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(message: _messages[index], sender: 'المحفوظات', updateApiPath: 'update_message_status.php',);
                    },
                  ),
      ),
    );
  }
}
