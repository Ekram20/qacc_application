import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/views/pdf_viewer_screen.dart';
import 'package:qacc_application/widgets/pdf_viewer_network_screen.dart';
import 'package:qacc_application/widgets/section_header.dart';
import 'package:url_launcher/url_launcher.dart';


class LeaveRequestDetailsScreen extends StatelessWidget {
    final Map<String, dynamic> request; // السماح بالقيم القابلة لأن تكون null

  const LeaveRequestDetailsScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    bool isTasked =
        request["isTasked"]?.toString().trim() != "لا"
        &&
        request["isTasked"] != null; // التحقق من الحالة


    return Scaffold(
      backgroundColor: Colors.white,
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
          // ✅ السماح بالسكرول لكامل الصفحة
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Gap(20),
              SectionHeader(title: 'تفاصيل طلبك'),
              Gap(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(request["leave_type"] != "اجازة طارئة")
                      buildDetailRow(
                          context,
                          "هل تم تكليف الموظف بواجب أو مهمة معينة للقيام بها",
                          request["isTasked"] ?? "غير متوفر"),
                          
                      // ✅ إظهار هذه الحقول فقط إذا كان isTasked = نعم
                      if (isTasked) ...[
                        buildDetailRow(context, "تاريخ التكليف",
                            request["task_date"] ?? "غير متوفر"),
                        buildDetailRow(context, "رقم كتاب التكليف",
                            request["book_number"] ?? "غير متوفر"),
                        buildDetailRow(context, "المهمة المكلف بها",
                            request["task"] ?? "غير متوفر"),
                        buildDetailRow(context, "الإدارة",
                            request["department"] ?? "غير متوفر"),
                      ],
                      buildFileRow(context, "ملف قرار التكليف",
                          request["decision_file"]),
                      buildDetailRow(context, "تاريخ الطلب",
                          request["request_date"] ?? "غير متوفر"),
                      buildDetailRow(context, "تاريخ بداية الإجازة",
                          request["start_date"] ?? "غير متوفر"),
                      buildDetailRow(context, "تاريخ نهاية الإجازة",
                          request["end_date"] ?? "غير متوفر"),
                      if (request["maternity_leave_duration"] != null)
                        buildDetailRow(context, "المدة",
                            request["maternity_leave_duration"]),
                      buildDetailRow(context, "عدد الأيام",
                          request["days"].toString() ?? "غير متوفر"),
                      buildDetailRow(context, "تاريخ العودة",
                          request["resume_date"] ?? "غير متوفر"),
                      buildFileRow(context, "ملف وثيقة الإجازة",
                          request["leave_document_file"]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label :", style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

Widget buildFileRow(context, String label, String? fileUrl) {
  if (fileUrl == null || fileUrl.isEmpty) {
    return SizedBox.shrink();
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            "$label:",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        IconButton(
          icon: Icon(Icons.open_in_new, color: Colors.blue),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFViewerNetworkScreen(fileUrl: fileUrl)
              ),
            );

          },
        ),
      ],
    ),
  );
}
