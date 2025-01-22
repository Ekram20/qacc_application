import 'package:flutter/material.dart';
import 'package:qacc_application/models/message_model.dart';
import 'package:url_launcher/url_launcher.dart';


class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                'من: ${message.createdBy}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 8),
              if (message.content != null)
                Text(message.content!, style: TextStyle(fontSize: 16)),
              if (message.fileUrl != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final url = message.fileUrl!;
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
                        Flexible(
                          child: Text(
                            message.fileName!,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.blue, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  message.createdAt,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

