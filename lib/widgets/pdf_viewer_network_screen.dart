
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerNetworkScreen extends StatelessWidget {
  final String fileUrl;

  const PDFViewerNetworkScreen({Key? key, required this.fileUrl}) : super(key: key);

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
            ),),
        title:             Text('PDF Viewer', style: Theme.of(context).textTheme.bodySmall),
        centerTitle: true,

      ),
      body: SfPdfViewer.network(
        fileUrl,
      ),
    );
  }
}
