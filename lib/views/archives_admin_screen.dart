import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/models/message_model.dart';
import 'package:qacc_application/widgets/message_bubble.dart';

class ArchivesAdminScreen extends StatelessWidget {
   ArchivesAdminScreen({super.key});
final List<Message> messages = [
  Message(
    id: 1, // معرف الرسالة
    employeeId: 1, // معرف الموظف
    content: 'يرجى مراجعة الملف المرفق', // نص الرسالة
    fileName: 'إسم الملف', // اسم الملف
    fileUrl: 'fileUrl', // رابط الملف
    createdBy: 'المدير العام', // مرسل الرسالة
    createdAt: '10:01 ص', // تحويل تاريخ الإرسال إلى DateTime
  )
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بريد المدير العام', style: Theme.of(context).textTheme.bodySmall),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          color: AppColors.white, // خلفية بيضاء
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10.0),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return /* MessageBubble(message: message) */;
            },
          ),
        ),
      ),
    );
  }
}
