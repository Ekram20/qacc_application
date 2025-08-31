import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:qacc_application/models/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:qacc_application/providers/employee_provider.dart';
import 'package:qacc_application/router/app_router.gr.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isTermsAccepted = true; // حالة Checkbox
  bool _isCheckingAuth = true; // حالة للتحقق من المصادقة

  @override
  void initState() {
    super.initState();
    _checkAuthState(); // التحقق من حالة المصادقة عند بدء التشغيل
  }

  // التحقق من حالة المصادقة عند فتح التطبيق
  Future<void> _checkAuthState() async {
    try {
      // نعطي فرصة لواجهة المستخدم أن تعرض شاشة التحميل أولاً
      // هذا يمنع الوميض السريع إذا كانت عملية التحقق سريعة جداً
      await Future.delayed(const Duration(milliseconds: 100));

      // التحقق من وجود مستخدم حالي في Firebase
      User? user = FirebaseAuth.instance.currentUser;

      // --- السيناريو 1: المستخدم مسجل دخوله ---
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        final String? employeeDataJson = prefs.getString('employee_data');

        Map<String, dynamic>? employeeData;

        // التحقق من وجود بيانات محفوظة محلياً أولاً
        if (employeeDataJson != null) {
          employeeData = jsonDecode(employeeDataJson);
        } else {
          // إذا لم توجد بيانات محلية، تحقق من الخادم
          employeeData = await checkEmployeeEmail(user.email!);
          // إذا كان الموظف صالحًا، احفظ بياناته محليًا للمرة القادمة
          if (employeeData != null) {
            await _saveEmployeeDataLocally(employeeData);
          }
        }

        // إذا تم العثور على بيانات الموظف (من أي مصدر)
        if (employeeData != null && mounted) {
          // تحديث حالة الموظف في التطبيق
          Provider.of<EmployeeProvider>(
            context,
            listen: false,
          ).setEmployeeData(employeeData);

          // الانتقال مباشرة إلى الشاشة الرئيسية
          context.router.replace(const BottomNavigationBarEmployees());

          // **الأهم**: الخروج من الدالة فورًا لمنع إعادة بناء الواجهة
          return;
        }
      }

      // --- السيناريو 2: المستخدم غير مسجل أو ليس له صلاحية ---
      // لن يتم الوصول إلى هذا الجزء إلا إذا فشلت كل الشروط أعلاه
      if (mounted) {
        setState(() {
          // الآن فقط، نسمح بإظهار واجهة تسجيل الدخول
          _isCheckingAuth = false;
        });
      }
    } catch (e) {
      print("❌ خطأ في التحقق من حالة المصادقة: $e");
      // في حالة حدوث أي خطأ، أظهر واجهة تسجيل الدخول كخيار احتياطي
      if (mounted) {
        setState(() {
          _isCheckingAuth = false;
        });
      }
    }
  }

  // حفظ بيانات الموظف محلياً
  Future<void> _saveEmployeeDataLocally(
    Map<String, dynamic> employeeData,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('employee_data', jsonEncode(employeeData));
  }

  // مسح بيانات الموظف المحفوظة محلياً
  Future<void> _clearEmployeeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('employee_data');
  }

  // تسجيل الدخول عبر Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1️⃣ بدء تسجيل الدخول باستخدام Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // المستخدم ألغى العملية

      // 2️⃣ الحصول على بيانات المصادقة
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3️⃣ إنشاء بيانات اعتماد Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4️⃣ تسجيل الدخول باستخدام Firebase
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      print("❌ حدث خطأ: $e");
      return null;
    }
  }

  // التحقق من البريد الإلكتروني في قاعدة البيانات واسترجاع بيانات الموظف
  Future<Map<String, dynamic>?> checkEmployeeEmail(String email) async {
    final response = await http.post(
      Uri.parse('https://hr.qacc.ly/php/check_employee_email.php'),
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['exists'] == true) {
        return data['employee']; // إرجاع بيانات الموظف فقط
      }
    }

    return null; // إرجاع null إذا لم يكن الموظف موجودًا
  }

  //Code-Get-Token
  Future<void> saveTokenToDatabase(String email) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken != null) {
      final response = await http.post(
        Uri.parse('https://hr.qacc.ly/php/save_fcm_token.php'),
        body: {'email': email, 'fcm_token': fcmToken},
      );

      if (response.statusCode == 200) {
        print("✅ تم حفظ FCM Token بنجاح");
      } else {
        print("❌ فشل في حفظ FCM Token: ${response.body}");
      }
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // يمنع إغلاقه بالضغط خارج الحوار
      builder: (context) {
        return Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            color: Colors.white,
            size: 50,
          ),
        );
      },
    );
  }

  // تنفيذ تسجيل الدخول
  void handleSignIn() async {
    showLoadingDialog(context); // ⬅️ إظهار Dialog قبل البدء

    UserCredential? userCredential = await signInWithGoogle();
    if (userCredential != null) {
      String email = userCredential.user!.email!;
      print("✅ تسجيل دخول ناجح: $email");

      Map<String, dynamic>? employeeData = await checkEmployeeEmail(email);

      if (employeeData != null) {
        await saveTokenToDatabase(email);
        await _saveEmployeeDataLocally(employeeData); // أضف هذا السطر

        // حفظ بيانات الموظف في EmployeeProvider2
        Provider.of<EmployeeProvider>(
          context,
          listen: false,
        ).setEmployeeData(employeeData);

        Navigator.of(context, rootNavigator: true).pop(); // ⬅️ إغلاق Dialog

        // الانتقال إلى الصفحة الرئيسية
        context.router.replace(BottomNavigationBarEmployees());
      } else {
        Navigator.of(context, rootNavigator: true).pop(); // ⬅️ إغلاق Dialog

        showDialog(
          context: context,
          builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              backgroundColor: AppColors.secondaryColor.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    "خطأ في الصلاحية",
                    style: TextStyle(color: AppColors.white),
                  ),
                ],
              ),
              content: Text(
                "ليس لديك صلاحية الدخول، يرجى مراجعة شؤون الموظفين",
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.right,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("حسنًا", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        );
        await FirebaseAuth.instance.signOut();
        await GoogleSignIn().signOut();
        await _clearEmployeeData(); // أضف هذا السطر
      }
    } else {
      Navigator.of(context, rootNavigator: true).pop(); // ⬅️ إغلاق Dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    // إذا كانت عملية التحقق جارية، قم ببناء شاشة تحميل بسيطة ومستقلة
    if (_isCheckingAuth) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.secondaryColor.shade900,
                AppColors.secondaryColor.shade500,
                AppColors.secondaryColor.shade900,
              ],
            ),
          ),
          child: Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.secondaryColor.shade900,
              AppColors.secondaryColor.shade500,
              AppColors.secondaryColor.shade900,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: Opacity(
                opacity: 0.1,
                child: BounceInDown(
                  duration: Duration(seconds: 2),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 650,
                    width: 700,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BounceInDown(
                      duration: Duration(seconds: 2),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 250,
                        width: 250,
                      ),
                    ),
                    Gap(10.0),
                    FadeInUp(
                      duration: Duration(seconds: 2),
                      child: AutoSizeText(
                        "!مرحبًا بك",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 1,
                        minFontSize: 12,
                        maxFontSize: 24,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gap(10),
                    FadeInUp(
                      duration: Duration(seconds: 2),
                      child: AutoSizeText(
                        "قم بتسجيل الدخول للمتابعة",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                        maxLines: 1,
                        minFontSize: 10,
                        maxFontSize: 18,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gap(30),
                    FadeInUp(
                      duration: Duration(seconds: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor.shade700,
                          borderRadius: BorderRadius.circular(50.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        width: double.infinity,
                        child: AnimatedOpacity(
                          opacity: _isTermsAccepted ? 1.0 : 0.5,
                          duration: Duration(milliseconds: 300),
                          child: MaterialButton(
                            onPressed: _isTermsAccepted
                                ? handleSignIn
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Directionality(
                                        textDirection: TextDirection
                                            .rtl, // هذا يضبط ترتيب العناصر من اليمين لليسار

                                        child: AlertDialog(
                                          backgroundColor:
                                              AppColors.secondaryColor.shade800,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          title: Row(
                                            children: [
                                              Icon(
                                                Icons.warning_amber_rounded,
                                                color: Colors.amber,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                "تنبيه",
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                            "يرجى الموافقة على الشروط والأحكام والقوانين قبل المتابعة",
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text(
                                                "حسنًا",
                                                style: TextStyle(
                                                  color: Colors.amber,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                            disabledColor: Colors.grey.shade600,
                            color: AppColors.secondaryColor.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      "Google تسجيل الدخول باستخدام",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      maxLines: 1,
                                      minFontSize: 10,
                                      maxFontSize: 16,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Gap(15.0),
                                  Image.asset(
                                    'assets/images/google-logo.png',
                                    height: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(15),
                    FadeInUp(
                      duration: Duration(seconds: 2),
                      child: Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale:
                                1.0, // يمكنك تعديل القيمة حسب الحجم الذي تريده

                            child: Checkbox(
                              value: _isTermsAccepted,
                              activeColor: Colors.white,
                              checkColor: AppColors.secondaryColor.shade700,
                              onChanged: (value) {
                                setState(() {
                                  _isTermsAccepted = value ?? false;
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child: AutoSizeText.rich(
                              TextSpan(
                                text: 'أوافق على ',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: 'الشروط والأحكام والقوانين',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: AppColors.primaryColor,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // استبدل هذا بالانتقال الفعلي لصفحة الشروط
                                        context.router.push(
                                          TermsConditionsRoute(),
                                        );
                                      },
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              minFontSize: 10,
                              maxFontSize: 16,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeText(
                      "© 2025 جميع الحقوق محفوظة",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      minFontSize: 10,
                      maxFontSize: 14,
                      textAlign: TextAlign.center,
                    ),
                    AutoSizeText(
                      "® م. إكرام العرضاوي ®  |  م. رحمة سعيد",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      minFontSize: 10,
                      maxFontSize: 16,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
