import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final String sender;

  const MessageBubble({required this.message, required this.sender, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String messageText = message['message_text']?.trim() ?? '';
    bool hasText = messageText.isNotEmpty;
    bool hasFile = message['file_url'] != null;

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
                'من: $sender',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),

              // إذا كان هناك نص نعرضه، وإذا لم يكن هناك نص ولكن يوجد ملف نعرض رسالة احترافية
              if (hasText)
                Text(messageText, style: const TextStyle(fontSize: 16))
              else if (hasFile)
                const Text(
                  'تمت مشاركة ملف',
                  style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),

              if (hasFile)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      final url = message['file_url'];
                      final fileName = message['file_name'] ?? '';

                      if (_isImage(fileName)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ImagePreviewScreen(imageUrl: url),
                          ),
                        );
                      } else {
                        _launchFile(url);
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.attach_file, color: Colors.blue),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            message['file_name'] ?? 'ملف مرفق',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  message['created_at'],
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isImage(String fileName) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    return imageExtensions.any((ext) => fileName.toLowerCase().endsWith(ext));
  }

  Future<void> _launchFile(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;

  const ImagePreviewScreen({required this.imageUrl, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
