import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async'; // لاستخدام Timer
import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/router/app_router.gr.dart';
import 'package:qacc_application/views/update_checker.dart';
import 'package:qacc_application/widgets/animated_text.dart';
import 'package:qacc_application/widgets/image_text_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  List<String> _adsImages = [];

  // لإجراء التمرير التلقائي
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    fetchAdsImages(); // استدعاء الدالة لجلب الصور من API
    // تحديث البيانات كل 10 ثوانٍ (أو حسب الحاجة)
    Timer.periodic(Duration(seconds: 5), (timer) {
      fetchAdsImages();
    });
    // بدء التمرير التلقائي
    _startAutoScroll();

    // التحقق من التحديثات بعد ثانيتين من فتح التطبيق
    Future.delayed(Duration(seconds: 1), () {
      UpdateChecker(
        updateUrl: "https://hr.qacc.ly/app/update.json",
      ).checkForUpdate(context);
    });
  }

  Future<void> fetchAdsImages() async {
    final String apiUrl = 'https://hr.qacc.ly/php/ads_api.php';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          _adsImages = jsonResponse
              .cast<String>(); // تحويل البيانات إلى List<String>
          _adsImages.insert(0, 'assets/images/cover.jpg');
          /*if (_adsImages.isEmpty) {
            _adsImages.add(
                'assets/images/cover.jpg'); // إذا كانت فارغة، أضف الصورة الافتراضية
          } */
        });
      } else {
        throw Exception('فشل في تحميل الإعلانات');
      }
    } catch (error) {
      print('حدث خطأ: $error');
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _adsImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // تسجيل الخروج
  void signOut(BuildContext context) async {
    // عرض حوار تأكيد منسق
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          // 1. لون الخلفية
          backgroundColor: AppColors.secondaryColor.shade800,
          // 2. حواف دائرية
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // 3. عنوان مخصص مع أيقونة
          title: Row(
            children: [
              Icon(
                Icons.logout, // أيقونة مناسبة لتسجيل الخروج
                color: Colors.amber,
              ),
              SizedBox(width: 10),
              Text(
                "تأكيد الخروج",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // 4. محتوى الرسالة
          content: Text(
            "هل أنت متأكد أنك تريد تسجيل الخروج؟",
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.right,
          ),
          // 5. أزرار الإجراءات
          actions: [
            // زر "نعم" (تأكيد)
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                "نعم",
                style: TextStyle(
                  color: Colors.amber, // لون للتأكيد
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // زر "لا" (إلغاء)
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                "لا",
                style: TextStyle(
                  color: Colors.white70, // لون محايد
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // إذا لم يقم المستخدم بالتأكيد، لا تفعل شيئًا
    if (confirm != true) {
      return;
    }

    // 1. تسجيل الخروج من خدمات المصادقة
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().disconnect();

    // 2. مسح بيانات الموظف المحفوظة محليًا
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('employee_data');

    // 3. مسح بيانات الموظف من حالة التطبيق (Provider)
    Provider.of<EmployeeProvider>(context, listen: false).clearEmployeeData();

    print("✅ تم تسجيل الخروج ومسح البيانات المحلية بنجاح.");

    // 4. الانتقال إلى شاشة تسجيل الدخول ومسح كل الشاشات السابقة
    if (mounted) {
      context.router.replaceAll([const LoginRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final employeeData = Provider.of<EmployeeProvider>(context).employeeData;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                context.router.push(RequestManagement());
              },
              icon: Icon(Icons.fact_check, color: AppColors.white, size: 35.0),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.facebookMessenger,
                color: AppColors.white,
                size: 30.0,
              ),
            ),
            // زر النقاط الثلاث
            PopupMenuButton<int>(
              icon: Icon(Icons.more_vert, color: AppColors.white, size: 30.0),
              onSelected: (item) {
                switch (item) {
                  case 4:
                    signOut(context);
                    break;
                  default:
                    print('خيار غير معروف');
                }
              },
              itemBuilder: (context) => [
                // عنصر غير قابل للتحديد: دليل الاستخدام
                PopupMenuItem<int>(
                  enabled: false,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ' دليل الاستخدام',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),

                // عنصر قابل للتحديد: تسجيل الخروج
                PopupMenuItem<int>(
                  value: 4,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ' تسجيل الخروج',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
/*         // ==================== ✨ الدعم الفني ✨ ====================
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // هنا سيتم الانتقال إلى شاشة الدردشة
            // سنقوم بإنشاء هذه الشاشة في الخطوة التالية
            // AutoRouter.of(context).push(SupportChatRoute());
            print("فتح شاشة الدعم الفني");
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.support_agent, color: Colors.white),
          tooltip: 'الدعم الفني',
        ),
        // ==================== 🔚 نهاية التعديل 🔚 ====================
 */        body: SingleChildScrollView(
          child: Column(
            children: [
              // عرض الإعلانات باستخدام PageView
              Container(
                height: 250.0,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _adsImages.length,
                  itemBuilder: (context, index) {
                    String imageUrl = _adsImages[index];

                    return GestureDetector(
                      onTap: () {
                        context.router.push(
                          FullRouteAdRoute(imageUrl: imageUrl),
                        );
                      },
                      child: imageUrl.startsWith('http')
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.broken_image,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                            )
                          : Image.asset(imageUrl, fit: BoxFit.cover),
                    );
                  },
                ),
              ),

              //Divider(),
              Gap(20.0),
              // إضافة النقاط لتوضيح عدد الإعلانات
              SmoothPageIndicator(
                controller: _pageController,
                count: _adsImages.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8,
                  activeDotColor: AppColors.primaryColor,
                ),
              ),
              // هنا سيتم استخدام Widget آخر مثل ImageTextCard
              Gap(15.0),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FadeInUp(
                  duration: Duration(seconds: 1),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                AutoRouter.of(
                                  context,
                                ).push(LeaveTypeSelectionRoute());
                              },
                              child: ImageTextCard(
                                image: 'assets/images/Google_Calendar.png',
                                mainText: 'طلب إجازة',
                              ),
                            ),
                          ),
                          Gap(15.0),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                //   AutoRouter.of(context)
                                //  .push(FormSelectionRoute());
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  ImageTextCard(
                                    image:
                                        'assets/images/Signing_A_Document.png',
                                    mainText: 'طلب نموذج',
                                  ),
                                  Positioned(
                                    top: -15,
                                    child: AnimatedText(
                                      texts: ['قريباً', 'ترقبوا'],
                                      startIndex: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(25.0),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // AutoRouter.of(context).push(ItemsOrderRoute());
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  ImageTextCard(
                                    image: 'assets/images/Create_Order.png',
                                    mainText: 'طلب أصناف',
                                  ),
                                  Positioned(
                                    top: -15,
                                    child: AnimatedText(
                                      texts: ['قريباً', 'ترقبوا'],
                                      startIndex: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(15.0),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                AutoRouter.of(
                                  context,
                                ).push(AttendanceTableRoute());
                              },
                              child: ImageTextCard(
                                image: 'assets/images/Fingerprint_Accepted.png',
                                mainText: 'الحضور والإنصراف',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(25.0),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // AutoRouter.of(context)
                                // .push(MaintenanceRequestType());
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  ImageTextCard(
                                    image: 'assets/images/Service.png',
                                    mainText: 'طلب الصيانة',
                                  ),
                                  Positioned(
                                    top: -15,
                                    child: AnimatedText(
                                      texts: ['قريباً', 'ترقبوا'],
                                      startIndex: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
