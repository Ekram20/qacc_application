import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class MessageScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(content: 'مرحبًا بك!', sender: 'الإدارة', time: '10:49 ص'),
    Message(
        content: 'يرجى مراجعة الملف المرفق.',
        sender: 'الإدارة',
        time: '11:15 ص',
        attachment: 'file.pdf'),
    Message(
        content: 'تحديثات جديدة مرفقة.',
        sender: 'الإدارة',
        time: '12:30 م',
        attachment: 'image.png'),
  ];

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
        child: Container(
          color: Colors.white, // خلفية بيضاء
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10.0),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // لون رمادي هادئ للفقاعة
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'من: ${message.sender}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(message.content, style: TextStyle(fontSize: 16)),
                        if (message.attachment != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: GestureDetector(
                              onTap: () async {
                                final url = message.attachment!;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('تعذر فتح الملف'),
                                    ),
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.attach_file, color: Colors.blue),
                                  SizedBox(width: 8),
                                  // إضافة TextOverflow.ellipsis هنا
                                  Flexible(
                                    child: Text(
                                      message.attachment!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 14),
                                    ),
                                  ),
                                ],                              ),
                            ),
                          ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            message.time,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Message {
  final String content;
  final String sender;
  final String time;
  final String? attachment;

  Message({
    required this.content,
    required this.sender,
    required this.time,
    this.attachment,
  });
}
