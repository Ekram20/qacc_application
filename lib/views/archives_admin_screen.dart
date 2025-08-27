import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/widgets/message_bubble.dart';

import '../widgets/circularProgressIndicator.dart';

class ArchivesAdminScreen extends StatefulWidget {
  const ArchivesAdminScreen({super.key});

  @override
  State<ArchivesAdminScreen> createState() => _ArchivesAdminScreenState();
}

class _ArchivesAdminScreenState extends State<ArchivesAdminScreen> {
  late int employeeId;
  List<dynamic> _messages = [];
  bool _isLoading = true;
  late Timer _timer;
  final ScrollController _scrollController = ScrollController();
  bool _shouldAutoScroll = true;
  bool _firstLoad = true; // للتحكم بالتحميل الأولي

  @override
  void initState() {
    super.initState();
    employeeId = Provider.of<EmployeeProvider>(
      context,
      listen: false,
    ).employeeData!["id"];
    _scrollController.addListener(_scrollListener);
    fetchMessages(); // تحميل البيانات أول مرة
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      fetchMessages();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _shouldAutoScroll = true;
        });
      }
    } else {
      setState(() {
        _shouldAutoScroll = false;
      });
    }
  }

  void _scrollToBottom({bool animated = true}) {
    if (_scrollController.hasClients) {
      if (animated) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    }
  }

  Future<void> fetchMessages() async {
    try {
      final url = Uri.parse(
        'https://hr.qacc.ly/php/messages_admin_app_api.php?employee_id=$employeeId',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> newMessages = json.decode(response.body);
        final bool messagesChanged = !listEquals(newMessages, _messages);

        if (messagesChanged) {
          final bool newMessageAdded = newMessages.length > _messages.length;

          setState(() {
            _messages = newMessages;
          });

          if (_firstLoad) {
            // التحميل الأولي: ثابت أسفل الصفحة بدون حركة
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToBottom(animated: false);
            });
            _firstLoad = false;
          } else if (newMessageAdded && _shouldAutoScroll) {
            // رسائل جديدة أثناء المشاهدة: انزلاق سلس
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToBottom();
            });
          }
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
        title: Text(
          'بريد المدير العام',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: _isLoading
            ? Center(child: CustomLoadingIndicator())
            : _messages.isEmpty
            ? Center(child: Text('لا يوجد لديك رسائل بعد'))
            : ListView.builder(
                controller: _scrollController,

                padding: EdgeInsets.only(top: 10.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return MessageBubble(
                    message: _messages[index],
                    sender: 'بريد المدير العام',
                    updateApiPath: 'update_message_admin_status.php',
                  );
                },
              ),
      ),
      // زر للتمرير إلى الأسفل عندما لا يكون التمرير التلقائي مفعلاً
      floatingActionButton: _shouldAutoScroll
          ? null
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  _shouldAutoScroll = true;
                });
                _scrollToBottom();
              },
              mini: true, 
              backgroundColor: AppColors.secondaryColor,
              child: Icon(
                Icons.arrow_downward,
                size: 20,
                color: const Color.fromARGB(
                  255,
                  255,
                  255,
                  255,
                ), 
              ),
            ),
    );
  }
}
