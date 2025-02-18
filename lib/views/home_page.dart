import 'dart:async'; // لاستخدام Timer
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:qacc_application/router/app_router.gr.dart';
import 'package:qacc_application/widgets/image_text_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final List<String> _adsImages = [
    'assets/images/cover.jpg', // صورة محلية 1
    'assets/images/cover.jpg', // صورة محلية 2
    'assets/images/cover.jpg', // صورة محلية 3
    'assets/images/cover.jpg', // صورة محلية 4
  ];

  // لإجراء التمرير التلقائي
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // بدء التمرير التلقائي
    _startAutoScroll();
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
                    print('تم اختيار الخيار 4');
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
                      child: Text('الخيار 1')),
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
                      child: Text('الخيار 4')),
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
                    return GestureDetector(
                      onTap: () {
                        // عند الضغط على الصورة، افتح صفحة جديدة لعرض الصورة بالحجم الكبير
                        context.router.push(
                            FullRouteAdRoute(imageUrl: _adsImages[index]));
                      },
                      child: Image.asset(
                        _adsImages[index],
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
                              AutoRouter.of(context).push(FormSelectionRoute());
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
                              AutoRouter.of(context).push(AttendanceTableRoute(employeeID: 103));
                            },
                            child: ImageTextCard(
                                image: 'assets/images/Fingerprint_Accepted.png',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
