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
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/router/app_router.gr.dart';
import 'package:qacc_application/widgets/image_text_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  final String email; // استقبال البريد الإلكتروني من تسجيل الدخول

  const HomePage({super.key, required this.email});

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

    // بدء التمرير التلقائي
    _startAutoScroll();
  }

  Future<void> fetchAdsImages() async {
    final String apiUrl = 'http://www.hr.qacc.ly/php/ads_api.php';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          print('ggggggggggggggggggggggggg $jsonResponse');
          _adsImages =
              jsonResponse.cast<String>(); // تحويل البيانات إلى List<String>
          _adsImages.insert(0, 'assets/images/cover.jpg');
        /*if (_adsImages.isEmpty) {
            _adsImages.add(
                'assets/images/cover.jpg'); // إذا كانت فارغة، أضف الصورة الافتراضية
          } */
                   print('ggggggggggggggggggggggggg $_adsImages');

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
      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // تسجيل الخروج
  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn()
        .disconnect(); // فصل الحساب بالكامل وإجبار إعادة الاختيار

    // الانتقال إلى الشاشة الرئيسية بعد نجاح المصادقة
    context.router.replace(LoginRoute()); // العودة إلى شاشة تسجيل الدخول
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.fact_check,
                color: AppColors.white,
                size: 35.0,
              ),
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
              icon: Icon(
                Icons.more_vert,
                color: AppColors.white,
                size: 30.0,
              ), // زر النقاط الثلاث
              onSelected: (item) {
                // التعامل مع العنصر المحدد
                switch (item) {
                  case 1:
                    print('تم اختيار الخيار 1');
                    break;
                  case 2:
                    print('تم اختيار الخيار 2');
                    break;
                  case 3:
                    print('تم اختيار الخيار 3');
                    break;
                  case 4:
                    signOut(context);
                    break;
                  default:
                    print('خيار غير معروف');
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(widget.email)),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('الخيار 2')),
                ),
                PopupMenuItem<int>(
                  value: 3,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('الخيار 3')),
                ),
                PopupMenuItem<int>(
                  value: 4,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('تسجيل الخروج')),
                ),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
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
                        context.router
                            .push(FullRouteAdRoute(imageUrl: imageUrl));
                      },
                      child: imageUrl.startsWith('http')
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.broken_image,
                                      size: 100, color: Colors.grey),
                            )
                          : Image.asset(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                    );
                  },
                ),
              ),

              //Divider(),
              Gap(15.0),
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
                                AutoRouter.of(context)
                                    .push(LeaveTypeSelectionRoute());
                              },
                              child: ImageTextCard(
                                  image: 'assets/images/Google_Calendar.png',
                                  mainText: 'طلب إجازة'),
                            ),
                          ),
                          Gap(15.0),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                AutoRouter.of(context)
                                    .push(FormSelectionRoute());
                              },
                              child: ImageTextCard(
                                  image: 'assets/images/Signing_A_Document.png',
                                  mainText: 'طلب نموذج'),
                            ),
                          ),
                        ],
                      ),
                      Gap(15.0),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                AutoRouter.of(context).push(ItemsOrderRoute());
                              },
                              child: ImageTextCard(
                                  image: 'assets/images/Create_Order.png',
                                  mainText: 'طلب أصناف'),
                            ),
                          ),
                          Gap(15.0),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                AutoRouter.of(context).push(
                                    AttendanceTableRoute(employeeID: 103));
                              },
                              child: ImageTextCard(
                                  image:
                                      'assets/images/Fingerprint_Accepted.png',
                                  mainText: 'الحضور والإنصراف'),
                            ),
                          ),
                        ],
                      ),
                      Gap(15.0),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                AutoRouter.of(context)
                                    .push(MaintenanceRequestType());
                              },
                              child: ImageTextCard(
                                  image: 'assets/images/Service.png',
                                  mainText: 'طلب الصيانة'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
