import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';

@RoutePage()
class FullScreenAdPage extends StatelessWidget {
  final String imageUrl;

  FullScreenAdPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('الإعلان', style: Theme.of(context).textTheme.bodySmall),
        centerTitle: true,
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
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(20), // هامش الحواف لتوسيع التحريك
          minScale: 1.0, // الحد الأدنى للتكبير
          maxScale: 5.0, // الحد الأقصى للتكبير
          child:imageUrl.startsWith('http')
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image, size: 100, color: Colors.grey),
                )
              : Image.asset(
                  imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
        ),
      ),
    );
  }
}