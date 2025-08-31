import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateChecker {
  final String updateUrl;

  UpdateChecker({required this.updateUrl});

  Future<void> checkForUpdate(BuildContext context) async {
    try {
      // أخذ نسخة التطبيق الحالي
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      final response = await http.get(Uri.parse(updateUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String latestVersion = data["latest_version"];
        String apkUrl = data["apk_url"];
        String changelog = data["changelog"] ?? "";

        debugPrint("🔹 الإصدار الحالي: $currentVersion");
        debugPrint("🔹 أحدث إصدار من الخادم: $latestVersion");

        if (_isVersionNewer(latestVersion, currentVersion)) {
          debugPrint("🔹 يوجد تحديث متاح!");
          _showUpdateDialog(context, apkUrl, latestVersion, changelog);
        } else {
          debugPrint("🔹 التطبيق محدث بالفعل");
        }
      } else {
        debugPrint("خطأ HTTP: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("خطأ في التحقق من التحديث: $e");
    }
  }

  bool _isVersionNewer(String latest, String current) {
    List<int> latestParts = latest
        .split('.')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();
    List<int> currentParts = current
        .split('.')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();

    for (int i = 0; i < latestParts.length; i++) {
      if (i >= currentParts.length) return true;
      if (latestParts[i] > currentParts[i]) return true;
      if (latestParts[i] < currentParts[i]) return false;
    }
    
    return latestParts.length > currentParts.length;
  }

  void _showUpdateDialog(
    BuildContext context,
    String apkUrl,
    String latestVersion,
    String changelog,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: AppColors.secondaryColor.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(Icons.system_update_rounded, color: Colors.amber),
                SizedBox(width: 8),
                Text("تحديث متاح", style: TextStyle(color: AppColors.white)),
              ],
            ),
            content: Text(
              "نسخة $latestVersion متوفرة الآن.\n\n$changelog",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.right,
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    await launchUrl(
                      Uri.parse(apkUrl),
                      mode: LaunchMode.externalApplication
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("تعذر فتح الرابط: $e")),
                    );
                  }
                },
                child: Text(
                  "تحديث الآن",
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}